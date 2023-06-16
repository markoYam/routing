import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/data/model/response/rutas_response_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';

class RutasProvider implements iRutasProvider {
  final api = 'controllers/rutas.php';
  @override
  Future<RutasResponseModel> create({required RutasModel rutas}) async {
    try {
      final data = rutas.toJson();
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
  Future<RutasResponseModel> delete({required RutasModel rutas}) async {
    try {
      final data = {
        'action': 'Delete', //! action que se va a ejecutar
        'idRuta': rutas.idRuteo, //! id de la ruta a eliminar
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
  Future<RutasResponseModel> update({required RutasModel rutas}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

abstract class iRutasProvider {
  Future<RutasResponseModel> getRutas();
  Future<RutasResponseModel> create({required RutasModel rutas});
  Future<RutasResponseModel> update({required RutasModel rutas});
  Future<RutasResponseModel> delete({required RutasModel rutas});
}
