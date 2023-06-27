part of 'rutas_cubit.dart';

class RutasState extends Equatable {
  const RutasState({
    this.lsRutas = const [],
    this.status = RutasStatus.initial,
    this.categoria,
  });
  final List<RutasModel> lsRutas;
  final RutasStatus status;
  final CategoriasModel? categoria;

  copyWith({
    List<RutasModel>? rutas,
    RutasStatus? status,
    CategoriasModel? categoria,
  }) {
    return RutasState(
      lsRutas: rutas ?? this.lsRutas,
      status: status ?? this.status,
      categoria: categoria ?? this.categoria,
    );
  }

  @override
  List<Object> get props => [status];
}

enum RutasStatus {
  initial,
  loading,
  success,
  error,
}
