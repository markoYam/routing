import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/estatus_model.dart';

class ParadasModel {
  final String idParada;
  final String nbParada;
  final String desParada;
  final String dcLatitud;
  final String dcLongitud;
  final String desDireccion;
  final String idRuta;
  final String idRepartidor;
  final String idEstatus;
  final String dcPrecioCompra;
  final String dcPrecioVenta;
  final String dcTotal;
  final EstatusModel? estatus;

  ParadasModel({
    required this.idParada,
    required this.nbParada,
    required this.desParada,
    required this.dcLatitud,
    required this.dcLongitud,
    required this.desDireccion,
    required this.idRuta,
    required this.idRepartidor,
    required this.idEstatus,
    required this.dcPrecioCompra,
    required this.dcPrecioVenta,
    required this.dcTotal,
    this.estatus,
  });

  ParadasModel copyWith({
    String? idParada,
    String? nbParada,
    String? desParada,
    String? dcLatitud,
    String? dcLongitud,
    String? desDireccion,
    String? idRuta,
    String? idRepartidor,
    String? idEstatus,
    String? dcPrecioCompra,
    String? dcPrecioVenta,
    String? dcTotal,
    EstatusModel? estatus,
  }) =>
      ParadasModel(
        idParada: idParada ?? this.idParada,
        nbParada: nbParada ?? this.nbParada,
        desParada: desParada ?? this.desParada,
        dcLatitud: dcLatitud ?? this.dcLatitud,
        dcLongitud: dcLongitud ?? this.dcLongitud,
        desDireccion: desDireccion ?? this.desDireccion,
        idRuta: idRuta ?? this.idRuta,
        idRepartidor: idRepartidor ?? this.idRepartidor,
        idEstatus: idEstatus ?? this.idEstatus,
        dcPrecioCompra: dcPrecioCompra ?? this.dcPrecioCompra,
        dcPrecioVenta: dcPrecioVenta ?? this.dcPrecioVenta,
        dcTotal: dcTotal ?? this.dcTotal,
        estatus: estatus ?? this.estatus,
      );

  factory ParadasModel.fromJson(dynamic json) => ParadasModel(
        idParada:
            Utils.convertDynamicToType(json["idParada"], defaultValue: ""),
        nbParada:
            Utils.convertDynamicToType(json["nbParada"], defaultValue: ""),
        desParada:
            Utils.convertDynamicToType(json["desParada"], defaultValue: ""),
        dcLatitud:
            Utils.convertDynamicToType(json["dcLatitud"], defaultValue: ""),
        dcLongitud:
            Utils.convertDynamicToType(json["dcLongitud"], defaultValue: ""),
        desDireccion:
            Utils.convertDynamicToType(json["desDireccion"], defaultValue: ""),
        idRuta: Utils.convertDynamicToType(json["idRuta"], defaultValue: ""),
        idRepartidor:
            Utils.convertDynamicToType(json["idRepartidor"], defaultValue: ""),
        idEstatus:
            Utils.convertDynamicToType(json["idEstatus"], defaultValue: ""),
        dcPrecioCompra: Utils.convertDynamicToType(json["dcPrecioCompra"],
            defaultValue: ""),
        dcPrecioVenta:
            Utils.convertDynamicToType(json["dcPrecioVenta"], defaultValue: ""),
        dcTotal: Utils.convertDynamicToType(json["dcTotal"], defaultValue: ""),
        estatus: json["estatus"] == null
            ? null
            : EstatusModel.fromJson(json["estatus"]),
      );

  Map<String, dynamic> toJson() => {
        "idParada": idParada,
        "nbParada": nbParada,
        "desParada": desParada,
        "dcLatitud": dcLatitud,
        "dcLongitud": dcLongitud,
        "desDireccion": desDireccion,
        "idRuta": idRuta,
        "idRepartidor": idRepartidor,
        "idEstatus": idEstatus,
        "dcPrecioCompra": dcPrecioCompra,
        "dcPrecioVenta": dcPrecioVenta,
        "dcTotal": dcTotal,
      };
}
