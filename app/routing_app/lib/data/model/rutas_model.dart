import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';

class RutasModel {
  final String idRuteo;
  final String nbRuteo;
  final DateTime feRegistro;
  final DateTime feEntrega;
  final String idEstatus;
  final String idCategoria;
  //final Estatus estatus;
  final CategoriasModel categoria;

  RutasModel({
    required this.idRuteo,
    required this.nbRuteo,
    required this.feRegistro,
    required this.feEntrega,
    required this.idEstatus,
    required this.idCategoria,
    //required this.estatus,
    required this.categoria,
  });

  RutasModel copyWith({
    String? idRuteo,
    String? nbRuteo,
    DateTime? feRegistro,
    DateTime? feEntrega,
    String? idEstatus,
    String? idCategoria,
    //Estatus? estatus,
    CategoriasModel? categoria,
  }) =>
      RutasModel(
        idRuteo: idRuteo ?? this.idRuteo,
        nbRuteo: nbRuteo ?? this.nbRuteo,
        feRegistro: feRegistro ?? this.feRegistro,
        feEntrega: feEntrega ?? this.feEntrega,
        idEstatus: idEstatus ?? this.idEstatus,
        idCategoria: idCategoria ?? this.idCategoria,
        //estatus: estatus ?? this.estatus,
        categoria: categoria ?? this.categoria,
      );

  factory RutasModel.fromJson(dynamic json) => RutasModel(
        idRuteo: Utils.convertDynamicToType(json["idRuteo"], defaultValue: '0'),
        nbRuteo: Utils.convertDynamicToType(json["nbRuteo"], defaultValue: ''),
        feRegistro: Utils.convertDynamicToType(
          json["feRegistro"],
          defaultValue: DateTime.now(),
        ),
        feEntrega: Utils.convertDynamicToType(
          json["feEntrega"],
          defaultValue: DateTime.now(),
        ),
        idEstatus: Utils.convertDynamicToType(
          json["idEstatus"],
          defaultValue: '0',
        ),
        idCategoria: Utils.convertDynamicToType(
          json["idCategoria"],
          defaultValue: '0',
        ),
        //estatus: Estatus.fromJson(json["estatus"]),
        categoria: CategoriasModel.fromJson(
          Utils.convertDynamicToType(
            json["categoria"],
            defaultValue: {},
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "idRuteo": idRuteo,
        "nbRuteo": nbRuteo,
        "feRegistro":
            "${feRegistro.year.toString().padLeft(4, '0')}-${feRegistro.month.toString().padLeft(2, '0')}-${feRegistro.day.toString().padLeft(2, '0')}",
        "feEntrega":
            "${feEntrega.year.toString().padLeft(4, '0')}-${feEntrega.month.toString().padLeft(2, '0')}-${feEntrega.day.toString().padLeft(2, '0')}",
        "idEstatus": idEstatus,
        "idCategoria": idCategoria,
        //"estatus": estatus.toJson(),
        "categoria": categoria.toJson(),
      };
}
