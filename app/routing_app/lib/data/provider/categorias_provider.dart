import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/response/categorias_response_model.dart';

class HomeProvider implements iHomeProvider {
  final api = 'controllers/categorias.php';
  @override
  Future<CategoriasResponseModel> getCategorias() async {
    try {
      final response = await DioSingleton.dio.get<Map<String, dynamic>>(api);
      return CategoriasResponseModel.fromJson(response.data!);
    } catch (e) {
      return CategoriasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<CategoriasResponseModel> createCategoria({
    required CategoriasModel categoriasModel,
  }) async {
    try {
      final data = categoriasModel.toJson();
      final arguments = {
        'action': 'Create',
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(api,
          data: data, queryParameters: arguments);
      return CategoriasResponseModel.fromJson(response.data!);
    } catch (e) {
      return CategoriasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<CategoriasResponseModel> deleteCategoria({
    required CategoriasModel categoriasModel,
  }) async {
    try {
      final data = {
        'action': 'Delete', //! action que se va a ejecutar
        'idCategoria': categoriasModel.idCategoria, //! id de la ruta a eliminar
      };
      final response = await DioSingleton.dio.get<Map<String, dynamic>>(
        api,
        queryParameters: data, //?action=Create&idCategoria=1
      );
      return CategoriasResponseModel.fromJson(response.data!);
    } catch (e) {
      return CategoriasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }

  @override
  Future<CategoriasResponseModel> updateCategoria({
    required CategoriasModel categoriasModel,
  }) async {
    try {
      final data = categoriasModel.toJson();
      final arguments = {
        'action': 'Update',
      };
      final response = await DioSingleton.dio.post<Map<String, dynamic>>(
        api,
        data: data,
        queryParameters: arguments, //?action=Update
      );
      return CategoriasResponseModel.fromJson(response.data!);
    } catch (e) {
      return CategoriasResponseModel(
        status: 0,
        message: e.toString(),
        data: [],
      );
    }
  }
}

abstract class iHomeProvider {
  Future<CategoriasResponseModel> getCategorias();
  Future<CategoriasResponseModel> createCategoria({
    required CategoriasModel categoriasModel,
  });
  Future<CategoriasResponseModel> updateCategoria({
    required CategoriasModel categoriasModel,
  });
  Future<CategoriasResponseModel> deleteCategoria({
    required CategoriasModel categoriasModel,
  });
}
