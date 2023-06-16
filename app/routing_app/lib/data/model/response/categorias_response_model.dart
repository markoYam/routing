import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/response/base_response.dart';

class CategoriasResponseModel extends BaseResponseModel {
  CategoriasResponseModel({
    required super.status,
    required super.message,
    required this.data,
  });

  final List<CategoriasModel> data;

  CategoriasResponseModel copyWith({
    int? status,
    String? message,
    List<CategoriasModel>? data,
  }) =>
      CategoriasResponseModel(
        status: status ?? super.status,
        message: message ?? super.message,
        data: data ?? this.data,
      );

  factory CategoriasResponseModel.fromJson(dynamic json) =>
      CategoriasResponseModel(
        status: Utils.convertDynamicToType(json["status"], defaultValue: 0),
        message: Utils.convertDynamicToType(json["message"], defaultValue: ""),
        data: List<CategoriasModel>.from(
          Utils.convertDynamicToType(json["data"], defaultValue: []).map(
            (x) => CategoriasModel.fromJson(x),
          ),
        ),
      );
}
