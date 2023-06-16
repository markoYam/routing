import 'package:routing_app/core/utils/utils.dart';

class CategoriasModel {
  final String idCategoria;
  final String nbCategoria;

  CategoriasModel({
    required this.idCategoria,
    required this.nbCategoria,
  });

  CategoriasModel copyWith({
    String? idCategoria,
    String? nbCategoria,
  }) =>
      CategoriasModel(
        idCategoria: idCategoria ?? this.idCategoria,
        nbCategoria: nbCategoria ?? this.nbCategoria,
      );

  factory CategoriasModel.fromJson(dynamic json) => CategoriasModel(
      idCategoria:
          Utils.convertDynamicToType(json["idCategoria"], defaultValue: ""),
      nbCategoria:
          Utils.convertDynamicToType(json["nbCategoria"], defaultValue: ""));

  Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria,
        "nbCategoria": nbCategoria,
      };
}
