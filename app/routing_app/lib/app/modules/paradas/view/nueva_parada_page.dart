import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:routing_app/app/modules/paradas/cubit/paradas_cubit.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/paradas_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
import 'package:routing_app/widgets/custom_drop_down_button.dart';
import 'package:routing_app/widgets/text_field_outline.dart';

class NuevaParadaPage extends StatefulWidget {
  const NuevaParadaPage({super.key, required this.ruta, required this.parada});

  final RutasModel ruta;
  final ParadasModel? parada;

  @override
  State<NuevaParadaPage> createState() => _NuevaParadaPageState();
}

class _NuevaParadaPageState extends State<NuevaParadaPage> {
  final TextEditingController _nbDireccionController = TextEditingController();
  final TextEditingController _nbParadaController = TextEditingController();
  final TextEditingController _desComentariosController =
      TextEditingController();
  final TextEditingController _dcTotalController = TextEditingController();
  GoogleMapController? _mapController;
  Position? _currentPosition;
  late ParadasCubit _paradasCubit;
  var _isInit = true;
  var latitud = 0.0;
  var longitud = 0.0;

  int? _selectedStatus = 4;
  final lsEstatus = [
    DropdownMenuItem(
      child: Text('Generado'),
      value: 4,
    ),
    DropdownMenuItem(
      child: Text('Entregado'),
      value: 5,
    ),
    DropdownMenuItem(
      child: Text('Cancelado'),
      value: 6,
    ),
  ];

  Future<void> crearParada() async {
    final parada = ParadasModel(
      idParada: (widget.parada?.idParada ?? 0).toString(),
      idRepartidor: '1',
      idRuta: _paradasCubit.state.ruta!.idRuteo,
      desDireccion: _nbDireccionController.text,
      nbParada: _nbParadaController.text,
      desParada: _desComentariosController.text,
      dcTotal: _dcTotalController.text,
      dcPrecioCompra: '0.0',
      dcPrecioVenta: '0.0',
      idEstatus: '${_selectedStatus!}',
      dcLatitud: latitud.toString(),
      dcLongitud: longitud.toString(),
    );
    _paradasCubit.createParada(parada: parada);
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await Utils.handleLocationPermission(
      context: context,
    );
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18,
          ),
        ),
      );
      setState(() {
        _currentPosition = position;
      });
      //_getAddressFromLatLng();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getCenterMapLocation() async {
    final visibleRegion = await _mapController!.getVisibleRegion();
    latitud = visibleRegion.southwest.latitude +
        (visibleRegion.northeast.latitude - visibleRegion.southwest.latitude) /
            2;
    longitud = visibleRegion.southwest.longitude +
        (visibleRegion.northeast.longitude -
                visibleRegion.southwest.longitude) /
            2;

    final address =
        await _paradasCubit.getAddressFromLatLng(lat: latitud, lng: longitud);
    _nbDireccionController.text = address ?? '';
  }

  bool isFirsTime = true;
  bool isCameraMove = false;
  @override
  Widget build(BuildContext context) {
    if (isFirsTime) {
      _getCurrentPosition();
      isFirsTime = false;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ParadasCubit()..init(ruta: widget.ruta),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ParadasCubit, ParadasState>(
            listener: (context, state) {
              if (state.status == ParadasStatus.created ||
                  state.status == ParadasStatus.updated) {
                Navigator.of(context).pop();
                Utils.showdialog(
                  context2: context,
                  success: true,
                  mgs: 'Operación realiza con éxito',
                  goBack: true,
                );
              } else if (state.status == ParadasStatus.saveInProcess) {
                //dialog de carga
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Guardando...',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state.status == ParadasStatus.errorSave) {
                Navigator.of(context).pop();
                Utils.showdialog(
                  context2: context,
                  success: false,
                  mgs: 'Ocurrio un error al realizar la operación',
                  goBack: false,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Nueva Parada'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              crearParada();
            },
            child: Icon(Icons.save),
          ),
          body: BlocBuilder<ParadasCubit, ParadasState>(
            builder: (context, state) {
              _paradasCubit = context.read<ParadasCubit>();
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getGoogleMaps(state),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: true,
                              child: TextFieldOutLine(
                                hintText: 'Dirección',
                                controller: _nbDireccionController,
                                prefixIcon: Icon(Icons.directions),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldOutLine(
                              hintText: 'Nombre',
                              controller: _nbParadaController,
                              prefixIcon: Icon(Icons.text_fields),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldOutLine(
                              hintText: 'Comentarios',
                              controller: _desComentariosController,
                              prefixIcon: Icon(Icons.description),
                              maxLines: 3,
                              keyboardType: TextFieldType.multiline,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFieldOutLine(
                                    hintText: 'Total',
                                    controller: _dcTotalController,
                                    prefixIcon:
                                        Icon(Icons.monetization_on_outlined),
                                    keyboardType: TextFieldType.number,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomDropDownButton(
                                    selectedValue: _selectedStatus ?? 1,
                                    lsItemsStatus: lsEstatus,
                                    hintText: 'Seleccione un estatus',
                                    onChanged: (int? value) {
                                      print(value);
                                      _selectedStatus = value;
                                    },
                                    prefixIcon: Icons.traffic_outlined,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox getGoogleMaps(ParadasState state) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveSingleton.height * 0.5,
      child: Stack(
        children: [
          //search bar

          GoogleMap(
            mapType: MapType.normal,
            onCameraMove: (position) {},
            onCameraIdle: () {
              isCameraMove = false;
              if (!isCameraMove) {
                log('onCameraMove');
                getCenterMapLocation();
              }
            },
            onCameraMoveStarted: () {
              isCameraMove = true;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(20.20585713545632, -89.28513303031421),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
          //search bar
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    elevation: 12,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Buscar',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        _paradasCubit.searchPlacesv2(
                          query: value,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: state.lsPlaces.isEmpty
                        ? 0
                        : ResponsiveSingleton.height * 0.28,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.lsPlaces.length,
                      itemBuilder: (context, index) {
                        final place = state.lsPlaces[index];
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              place.formattedAddress!,
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            onTap: () {
                              _mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      place.geometry!.location.lat,
                                      place.geometry!.location.lng,
                                    ),
                                    zoom: 18,
                                  ),
                                ),
                              );
                              _nbDireccionController.text =
                                  place.formattedAddress!;

                              setState(() {
                                //_currentAddress = place.formattedAddress;
                                latitud = place.geometry!.location.lat;
                                longitud = place.geometry!.location.lng;
                              });
                              _paradasCubit.clearPlaces();
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
