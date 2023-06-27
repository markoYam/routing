import 'dart:convert';

import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/data/model/paradas_model.dart';
import 'package:routing_app/data/model/response/base_response.dart';
import 'package:routing_app/data/model/response/paradas_response_model.dart';

class ParadasProvider implements IParadasProvider {
  final api = 'controllers/paradas.php';

  @override
  Future<BaseResponseModel> createParada({required ParadasModel parada}) async {
    try {
      final data = parada.toJson();
      final args = {
        "action": "Create",
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api,
        data: data,
        queryParameters: args,
      );
      return BaseResponseModel.fromJson(response.data!);
    } catch (e) {
      return BaseResponseModel(
        status: 0,
        message: e.toString(),
      );
    }
  }

  @override
  Future<BaseResponseModel> deleteParada({required int idParada}) async {
    try {
      final data = {
        "idParada": idParada,
      };
      final args = {
        "action": "Delete",
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api,
        data: data,
        queryParameters: args,
      );
      return BaseResponseModel.fromJson(response.data!);
    } catch (e) {
      return BaseResponseModel(
        status: 0,
        message: e.toString(),
      );
    }
  }

  Future<String?> getAddressFromLatLng(
      {required double lat, required double lng}) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1';

    final response = await DioSingleton.dio.get<String>(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.data!);
      final address = data['display_name'];
      return address;
    } else {
      return null;
    }
  }

  @override
  Future<ParadasResponseModel> getParadas({required int idRuta}) async {
    try {
      final data = {
        "idRuta": idRuta,
      };
      final args = {
        "action": "getByRuta",
        "idRuta": idRuta,
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api,
        //data: data,
        queryParameters: args,
      );
      return ParadasResponseModel.fromJson(response.data!);
    } catch (e) {
      return ParadasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<ParadasResponseModel> getParadasByEstatus({required int idEstatus}) {
    // TODO: implement getParadasByEstatus
    throw UnimplementedError();
  }

  @override
  Future<ParadasResponseModel> getParadasByRepartidor(
      {required int idRepartidor}) {
    // TODO: implement getParadasByRepartidor
    throw UnimplementedError();
  }

  @override
  Future<BaseResponseModel> updateParada({required ParadasModel parada}) async {
    try {
      final data = parada.toJson();
      final args = {
        "action": "Update",
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api,
        data: data,
        queryParameters: args,
      );
      return BaseResponseModel.fromJson(response.data!);
    } catch (e) {
      return BaseResponseModel(
        status: 0,
        message: e.toString(),
      );
    }
  }
}

abstract class IParadasProvider {
  Future<ParadasResponseModel> getParadas({required int idRuta});
  Future<ParadasResponseModel> getParadasByRepartidor({
    required int idRepartidor,
  });
  Future<ParadasResponseModel> getParadasByEstatus({required int idEstatus});
  Future<BaseResponseModel> createParada({required ParadasModel parada});
  Future<BaseResponseModel> updateParada({required ParadasModel parada});
  Future<BaseResponseModel> deleteParada({required int idParada});
  Future<String?> getAddressFromLatLng(
      {required double lat, required double lng});
}
