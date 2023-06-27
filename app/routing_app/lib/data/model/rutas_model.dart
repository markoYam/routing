import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';

class RutasModel {
  final String idRuteo;
  final String nbRuteo;
  final String feRegistro;
  final String feEntrega;
  final String idEstatus;
  final String idCategoria;
  //final Estatus estatus;
  final CategoriasModel categoria;
  final String numParadas;

  String getFechaCortaEntrega() {
    //return Utils.getFechaCorta(this.feEntrega);
    return this.feEntrega;
  }

  String getFechaCortaRegistro() {
    //return Utils.getFechaCorta(this.feRegistro);
    return this.feRegistro;
  }

  RutasModel({
    required this.idRuteo,
    required this.nbRuteo,
    required this.feRegistro,
    required this.feEntrega,
    required this.idEstatus,
    required this.idCategoria,
    //required this.estatus,
    required this.categoria,
    required this.numParadas,
  });

  RutasModel copyWith({
    String? idRuteo,
    String? nbRuteo,
    String? feRegistro,
    String? feEntrega,
    String? idEstatus,
    String? idCategoria,
    //Estatus? estatus,
    CategoriasModel? categoria,
    String? numParadas,
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
        numParadas: numParadas ?? this.numParadas,
      );

  factory RutasModel.fromJson(dynamic json) => RutasModel(
        idRuteo: Utils.convertDynamicToType(json["idRuteo"], defaultValue: '0'),
        nbRuteo: Utils.convertDynamicToType(json["nbRuteo"], defaultValue: ''),
        feRegistro: Utils.convertDynamicToType(
          json["feRegistro"],
          defaultValue: DateTime.now().toshortString(),
        ),
        feEntrega: Utils.convertDynamicToType(
          json["feEntrega"],
          defaultValue: DateTime.now().toshortString(),
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
        numParadas: Utils.convertDynamicToType(
          json["numParadas"],
          defaultValue: '0',
        ),
      );

  Map<String, dynamic> toJson() => {
        "idRuteo": idRuteo,
        "nbRuteo": nbRuteo,
        "feRegistro": feRegistro,
        "feEntrega": feEntrega,
        "idEstatus": idEstatus,
        "idCategoria": idCategoria,
        //"estatus": estatus.toJson(),
        //"categoria": categoria.toJson(),
        //"numParadas": numParadas,
      };
}
