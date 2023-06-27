import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
import 'package:routing_app/data/provider/rutas_provider.dart';
import 'package:routing_app/widgets/custom_dialog_widget.dart';

part 'rutas_state.dart';

class RutasCubit extends Cubit<RutasState> {
  RutasCubit() : super(RutasState());

  IRutasProvider iRutasProvider = RutasProvider();

  void init({required CategoriasModel categoria}) {
    emit(state.copyWith(
      categoria: categoria,
      status: RutasStatus.success,
    ));
  }

  Future<void> getRutas() async {
    emit(state.copyWith(status: RutasStatus.loading));
    final response =
        await iRutasProvider.getByIdCategoria(categoria: state.categoria!);
    if (response.status == 1) {
      emit(state.copyWith(
        rutas: response.data,
        status: RutasStatus.success,
      ));
    } else {
      emit(state.copyWith(
        rutas: [],
        status: RutasStatus.error,
      ));
    }
  }

  Future<void> createRuta({
    required RutasModel ruta,
    required BuildContext ctx,
  }) async {
    emit(state.copyWith(status: RutasStatus.loading));
    final response = await iRutasProvider.create(ruta: ruta);
    if (response.status == 1) {
      emit(state.copyWith(
        status: RutasStatus.success,
      ));
      Utils.showdialog(
        context2: ctx,
        success: true,
        mgs: response.message,
        goBack: true,
      );
    } else {
      emit(state.copyWith(
        status: RutasStatus.error,
      ));
      Utils.showdialog(
        context2: ctx,
        success: false,
        mgs: response.message,
        goBack: false,
      );
    }
  }

  Future<void> _deleteRuta({
    required RutasModel ruta,
    required BuildContext ctx,
  }) async {
    emit(state.copyWith(status: RutasStatus.loading));
    final response = await iRutasProvider.delete(ruta: ruta);
    if (response.status == 1) {
      getRutas();
      Utils.showdialog(
        context2: ctx,
        success: true,
        mgs: response.message,
        goBack: false,
      );
    } else {
      emit(state.copyWith(
        status: RutasStatus.error,
      ));
      Utils.showdialog(
        context2: ctx,
        success: false,
        mgs: response.message,
        goBack: false,
      );
    }
  }

  Future<void> deleteRuta({
    required RutasModel ruta,
    required BuildContext ctx,
  }) async {
    showDialog(
      context: ctx,
      builder: (context) {
        return CustomDialog(
          title: 'Ruta',
          message: '¿Está seguro de eliminar la ruta?',
          showCancel: true,
          type: DialogType.warning,
          onPressedOK: () async {
            Navigator.pop(ctx);
            await _deleteRuta(ruta: ruta, ctx: ctx);
          },
          onPressedCancel: () => Navigator.pop(ctx),
        );
      },
    );
  }

  void updateRuta({required RutasModel ruta, required BuildContext ctx}) {
    emit(state.copyWith(status: RutasStatus.loading));
    iRutasProvider.update(ruta: ruta).then((response) {
      if (response.status == 1) {
        //getRutas();
        Utils.showdialog(
          context2: ctx,
          success: true,
          mgs: response.message,
          goBack: true,
        );
      } else {
        emit(state.copyWith(
          status: RutasStatus.error,
        ));
        Utils.showdialog(
          context2: ctx,
          success: false,
          mgs: response.message,
          goBack: false,
        );
      }
    });
  }
}
