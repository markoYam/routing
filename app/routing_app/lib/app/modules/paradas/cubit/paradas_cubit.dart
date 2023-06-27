import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:routing_app/app/modules/paradas/view/paradas_page.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/paradas_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
import 'package:routing_app/data/provider/paradas_provider.dart';

part 'paradas_state.dart';

class ParadasCubit extends Cubit<ParadasState> {
  ParadasCubit() : super(ParadasState());

  final IParadasProvider _paradasProvider = ParadasProvider();
  final places = GoogleMapsPlaces(apiKey: Utils.api_key);
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Utils.api_key);

  void init({required RutasModel ruta}) {
    emit(state.copyWith(status: ParadasStatus.success, ruta: ruta));
  }

  Future<void> clearPlaces() async {
    emit(state.copyWith(status: ParadasStatus.loading));
    emit(state.copyWith(lsPlaces: [], status: ParadasStatus.success));
  }

  Future<PlaceDetails?> displayPrediction(
      {required Prediction? prediction}) async {
    if (prediction == null) return null;
    final response = await _places.getDetailsByPlaceId(prediction.placeId!);
    if (response.status == "OK") {
      return response.result;
    } else {
      return null;
    }
  }

  Future<void> searchPlacesv2({required String query}) async {
    emit(state.copyWith(status: ParadasStatus.loading));

    await _places.autocomplete(
      query,
      language: "es",
      components: [Component(Component.country, "mx")],
    ).then(
      (value) async {
        final lsPlaces = <PlaceDetails>[];
        for (var item in value.predictions) {
          final place = await displayPrediction(prediction: item);
          if (place != null) {
            log(place.formattedAddress!);
            lsPlaces.add(place);
          }
        }
        emit(state.copyWith(
          status: ParadasStatus.success,
          lsPlaces: lsPlaces,
        ));
      },
    ).onError(
      (error, stackTrace) {
        emit(state.copyWith(
          status: ParadasStatus.success,
          lsPlaces: [],
        ));
      },
    );
  }

  Future<void> searchPlaces(String searchTerm,
      {required Location? location}) async {
    emit(state.copyWith(status: ParadasStatus.loading));
    final response = await places.searchByText(
      searchTerm,
      location: location,
      radius: 10000,
    );
    if (response.status == "OK") {
      response.results.forEach((element) {
        log(element.formattedAddress!);
      });
      emit(state.copyWith(
        status: ParadasStatus.success,
        //lsPlaces: response.results,
      ));
    } else {
      emit(state.copyWith(
        status: ParadasStatus.success,
        lsPlaces: [],
      ));
    }
  }

  Future<void> getParadas({required BuildContext context}) async {
    emit(state.copyWith(status: ParadasStatus.loading));
    final response = await _paradasProvider.getParadas(
      idRuta: state.ruta!.idRuteo.toInt(),
    );
    if (response.status == 1) {
      generateMarkers(lsParadas: response.data, context: context);
    } else {
      emit(state.copyWith(status: ParadasStatus.error));
    }
  }

  Future<void> generateMarkers(
      {required BuildContext context,
      required List<ParadasModel> lsParadas}) async {
    emit(state.copyWith(status: ParadasStatus.loading));
    final lsMarkers = <Marker>[];
    for (var item in lsParadas) {
      final marker = Marker(
        markerId: MarkerId(item.idParada.toString()),
        position: LatLng(item.dcLatitud.toDouble(), item.dcLongitud.toDouble()),
        //infoWindow: InfoWindow.fromAnchor,
        onTap: () {
          log('Marker Tapped');
          //id marker
          //id parada
          showDialogMarker(context: context, parada: item);
        },
        icon: BitmapDescriptor.fromBytes(await getIconMarkerFromText(
          numParada: item.idParada.toInt(),
          idEstatus: item.idEstatus.toInt(),
        )),
      );
      lsMarkers.add(marker);
    }
    emit(state.copyWith(
      status: ParadasStatus.success,
      lsParadas: lsParadas,
      lsMarkers: lsMarkers,
    ));
  }

  void showDialogMarker(
      {required BuildContext context, required ParadasModel parada}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
          );
        });
  }

  Future<String?> getAddressFromLatLng(
      {required double lat, required double lng}) async {
    return await _paradasProvider.getAddressFromLatLng(lat: lat, lng: lng);
  }

  Future<Uint8List> getIconMarkerFromText({
    required int numParada,
    required int idEstatus,
  }) async {
    return Utils.getBytesFromCanvas(
      width: ResponsiveSingleton.proportionalWidth(70).toInt(),
      height: ResponsiveSingleton.propotionalHeight(70).toInt(),
      color: (idEstatus == 4)
          ? Colors.grey
          : (idEstatus == 5)
              ? Colors.green
              : Colors.red,
      text: '#' + numParada.toString(),
    );
  }

  Future<void> createParada({required ParadasModel parada}) async {
    emit(state.copyWith(status: ParadasStatus.saveInProcess));
    final response = await _paradasProvider.createParada(parada: parada);
    if (response.status == 1) {
      emit(state.copyWith(
        status: ParadasStatus.created,
      ));
    } else {
      log(response.message);
      emit(state.copyWith(status: ParadasStatus.errorSave));
    }
  }

  Future<void> deleteParada({required int idParada}) async {
    emit(state.copyWith(status: ParadasStatus.saveInProcess));
    final response = await _paradasProvider.deleteParada(idParada: idParada);
    if (response.status == 1) {
      emit(state.copyWith(
        status: ParadasStatus.deleted,
      ));
    } else {
      log(response.message);
      emit(state.copyWith(status: ParadasStatus.errorSave));
    }
  }

  Future<void> updateParada({required ParadasModel parada}) async {
    emit(state.copyWith(status: ParadasStatus.saveInProcess));
    final response = await _paradasProvider.updateParada(parada: parada);
    if (response.status == 1) {
      emit(state.copyWith(
        status: ParadasStatus.updated,
      ));
    } else {
      log(response.message);
      emit(state.copyWith(status: ParadasStatus.errorSave));
    }
  }
}
