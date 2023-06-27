part of 'paradas_cubit.dart';

class ParadasState extends Equatable {
  const ParadasState({
    this.status = ParadasStatus.initial,
    this.ruta,
    this.lsParadas = const [],
    this.lsPlaces = const [],
    this.lsMarkers = const [],
  });

  //final List<ParadasModel> paradas;
  final ParadasStatus status;
  final RutasModel? ruta;
  final List<ParadasModel> lsParadas;
  final List<PlaceDetails> lsPlaces;
  final List<Marker> lsMarkers;

  copyWith({
    ParadasStatus? status,
    RutasModel? ruta,
    List<ParadasModel>? lsParadas,
    List<PlaceDetails>? lsPlaces,
    List<Marker>? lsMarkers,
  }) {
    return ParadasState(
      status: status ?? this.status,
      ruta: ruta ?? this.ruta,
      lsParadas: lsParadas ?? this.lsParadas,
      lsPlaces: lsPlaces ?? this.lsPlaces,
      lsMarkers: lsMarkers ?? this.lsMarkers,
    );
  }

  @override
  List<Object> get props => [status];
}

enum ParadasStatus {
  initial,
  loading,
  success,
  error,
  errorSave,
  created,
  updated,
  deleted,
  saveInProcess,
}
