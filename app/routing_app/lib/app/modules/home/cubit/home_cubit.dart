import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/provider/categorias_provider.dart';
import 'package:routing_app/widgets/custom_dialog_widget.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final iHomeProvider = HomeProvider();

  Future<void> getCategorias() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await iHomeProvider.getCategorias();
    if (response.status == 1) {
      emit(state.copyWith(
        categorias: response.data,
        status: HomeStatus.success,
      ));
    } else {
      emit(state.copyWith(
        categorias: [],
        status: HomeStatus.error,
      ));
    }
  }

  Future<void> createCategoria({
    required CategoriasModel categoriasModel,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await iHomeProvider.createCategoria(
      categoriasModel: categoriasModel,
    );
    if (response.status == 1) {
      emit(state.copyWith(
        categorias: response.data,
        status: HomeStatus.success,
      ));
      showdialog(context, true, response.message, true);
    } else {
      emit(state.copyWith(
        categorias: [],
        status: HomeStatus.error,
      ));
      showdialog(context, false, response.message, false);
    }
  }

  void showdialog(
      BuildContext context2, bool success, String mgs, bool goBack) {
    showDialog(
      context: context2,
      builder: (context) {
        return CustomDialog(
          title: 'Categoría',
          message: mgs,
          showCancel: false,
          type: success ? DialogType.success : DialogType.error,
          onPressedOK: () {
            Navigator.pop(context);
            if (goBack) {
              Navigator.pop(context);
            }
          },
          onPressedCancel: () => null,
        );
      },
    );
  }

  Future<void> _deleteCategoria(
    CategoriasModel categoriasModel,
    BuildContext context,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await iHomeProvider.deleteCategoria(
      categoriasModel: categoriasModel,
    );
    if (response.status == 1) {
      getCategorias();
      showdialog(context, true, response.message, false);
    } else {
      emit(state.copyWith(
        categorias: [],
        status: HomeStatus.error,
      ));
      showdialog(context, false, response.message, false);
    }
  }

  Future<void> deleteCategoria({
    required CategoriasModel categoriasModel,
    required BuildContext context2,
  }) async {
    showDialog(
      context: context2,
      builder: (context) {
        return CustomDialog(
          title: 'Categoría',
          message: '¿Está seguro de eliminar la categoría?',
          showCancel: true,
          type: DialogType.warning,
          onPressedOK: () async {
            Navigator.pop(context);
            await _deleteCategoria(categoriasModel, context2);
          },
          onPressedCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  Future<void> updateCategoria({
    required CategoriasModel categoriasModel,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final response = await iHomeProvider.updateCategoria(
      categoriasModel: categoriasModel,
    );
    if (response.status == 1) {
      emit(state.copyWith(
        categorias: response.data,
        status: HomeStatus.success,
      ));
      showdialog(context, true, response.message, true);
    } else {
      emit(state.copyWith(
        categorias: [],
        status: HomeStatus.error,
      ));
      showdialog(context, false, response.message, false);
    }
  }
}
