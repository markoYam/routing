import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/response/rutas_response_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';

class RutasProvider implements IRutasProvider {
  final api = 'controllers/ruteo.php';
  @override
  Future<RutasResponseModel> create({required RutasModel ruta}) async {
    try {
      final data = ruta.toJson();
      final arguments = {
        'action': 'Create', //! action que se va a ejecutar
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api, //! api
        data: data, //! data a enviar
        queryParameters: arguments, //?action=Create
      );
      return RutasResponseModel.fromJson(response.data!);
    } catch (e) {
      return RutasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<RutasResponseModel> delete({required RutasModel ruta}) async {
    try {
      final data = {
        'action': 'Delete', //! action que se va a ejecutar
        'idRuteo': ruta.idRuteo, //! id de la ruta a eliminar
      };
      final response = await DioSingleton.dio.get<Map<String, dynamic>>(
        api,
        queryParameters: data, //?action=Delete&idRuta=1
      );
      return RutasResponseModel.fromJson(response.data!);
    } catch (e) {
      return RutasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<RutasResponseModel> getRutas() async {
    try {
      final response = await DioSingleton.dio.get<Map<String, dynamic>>(api);
      return RutasResponseModel.fromJson(response.data!);
    } catch (e) {
      return RutasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<RutasResponseModel> update({required RutasModel ruta}) async {
    try {
      final data = ruta.toJson();
      final arguments = {
        'action': 'Update', //! action que se va a ejecutar
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api, //! api
        data: data, //! data a enviar
        queryParameters: arguments, //?action=Update
      );
      return RutasResponseModel.fromJson(response.data!);
    } catch (e) {
      return RutasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<RutasResponseModel> getByIdCategoria(
      {required CategoriasModel categoria}) async {
    try {
      final data = {
        'action': 'getByIdCategoria', //! action que se va a ejecutar
        'idCategoria': categoria.idCategoria, //! id de la ruta a eliminar
      };
      final response = await DioSingleton.dio.get<Map<String, dynamic>>(
        api,
        queryParameters: data, //?action=getByIdCategoria&idCategoria=1
      );
      return RutasResponseModel.fromJson(response.data!);
    } catch (e) {
      return RutasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }
}

abstract class IRutasProvider {
  Future<RutasResponseModel> getRutas();
  Future<RutasResponseModel> create({required RutasModel ruta});
  Future<RutasResponseModel> update({required RutasModel ruta});
  Future<RutasResponseModel> delete({required RutasModel ruta});
  Future<RutasResponseModel> getByIdCategoria(
      {required CategoriasModel categoria});
}
