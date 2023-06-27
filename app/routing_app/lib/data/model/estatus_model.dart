import 'package:routing_app/core/utils/utils.dart';

class EstatusModel {
  final String idEstatus;
  final String nbEstatus;
  final String nbModulo;

  EstatusModel({
    required this.idEstatus,
    required this.nbEstatus,
    required this.nbModulo,
  });

  EstatusModel copyWith({
    String? idEstatus,
    String? nbEstatus,
    String? nbModulo,
  }) =>
      EstatusModel(
        idEstatus: idEstatus ?? this.idEstatus,
        nbEstatus: nbEstatus ?? this.nbEstatus,
        nbModulo: nbModulo ?? this.nbModulo,
      );

  factory EstatusModel.fromJson(dynamic json) => EstatusModel(
        idEstatus:
            Utils.convertDynamicToType(json["idEstatus"], defaultValue: ""),
        nbEstatus:
            Utils.convertDynamicToType(json["nbEstatus"], defaultValue: ""),
        nbModulo:
            Utils.convertDynamicToType(json["nbModulo"], defaultValue: ""),
      );

  Map<String, dynamic> toJson() => {
        "idEstatus": idEstatus,
        "nbEstatus": nbEstatus,
        "nbModulo": nbModulo,
      };
}
