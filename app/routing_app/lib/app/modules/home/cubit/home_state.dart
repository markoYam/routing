part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({
    this.categorias = const [],
    this.status = HomeStatus.initial,
  });

  // se crea una lista de categorias
  final List<CategoriasModel> categorias;
  // se crea una variable de tipo HomeStatus
  final HomeStatus status;

  // se crea un metodo para copiar el estado actual y modificarlo
  HomeState copyWith({
    List<CategoriasModel>? categorias,
    HomeStatus? status,
  }) =>
      HomeState(
        categorias: categorias ?? this.categorias,
        status: status ?? this.status,
      );

  //se enlista las propiedades que se van a comparar
  @override
  List<Object> get props => [status];
}

// se crea un enum para el estado de la pantalla
enum HomeStatus {
  initial,
  loading,
  success,
  error,
}
