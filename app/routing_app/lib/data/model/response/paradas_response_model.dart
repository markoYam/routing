import 'package:routing_app/data/model/paradas_model.dart';
import 'package:routing_app/data/model/response/base_response.dart';

class ParadasResponseModel extends BaseResponseModel {
  ParadasResponseModel({
    required super.status,
    required super.message,
    required this.data,
  });
  final List<ParadasModel> data;

  factory ParadasResponseModel.fromJson(Map<String, dynamic> json) =>
      ParadasResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<ParadasModel>.from(
          json["data"].map(
            (x) => ParadasModel.fromJson(x),
          ),
        ),
      );
}
