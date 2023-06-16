import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/response/base_response.dart';
import 'package:routing_app/data/model/rutas_model.dart';

class RutasResponseModel extends BaseResponseModel {
  RutasResponseModel({
    required super.status,
    required super.message,
    required this.data,
  });
  final List<RutasModel> data;

  factory RutasResponseModel.fromJson(Map<String, dynamic> json) =>
      RutasResponseModel(
        status: Utils.convertDynamicToType(json["status"], defaultValue: 0),
        message: Utils.convertDynamicToType(json["message"], defaultValue: ""),
        data: List<RutasModel>.from(
          Utils.convertDynamicToType(
            json["data"],
            defaultValue: [],
          ).map(
            (x) => RutasModel.fromJson(x),
          ),
        ),
      );
}
