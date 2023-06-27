import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/modules/categorias/cubit/categorias_cubit.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/widgets/custom_button_widget.dart';
import 'package:routing_app/widgets/text_field_outline.dart';

class NuevaCategoriaPage extends StatefulWidget {
  NuevaCategoriaPage({super.key, required this.categoria});

  final CategoriasModel? categoria;

  @override
  State<NuevaCategoriaPage> createState() => _NuevaCategoriaPageState();
}

class _NuevaCategoriaPageState extends State<NuevaCategoriaPage> {
  final TextEditingController nbCategoriaController = TextEditingController();

  late CategoriasCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    nbCategoriaController.text = widget.categoria?.nbCategoria ?? '';
    return BlocProvider(
      create: (context) => CategoriasCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.categoria?.idCategoria == 0 ? 'Nueva' : 'Editar'} Categoría'),
          centerTitle: true,
        ),
        body: BlocBuilder<CategoriasCubit, HomeState>(
          builder: (context, state) {
            homeCubit = context.read<CategoriasCubit>();

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.category,
                    size: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  TextFieldOutLine(
                    hintText: 'Nombre',
                    controller: nbCategoriaController,
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  if (state.status == HomeStatus.loading)
                    CircularProgressIndicator()
                  else
                    CustomButtonWidget(
                      hintText: 'Guardar',
                      onPressed: () {
                        //dismiss keyboard
                        FocusScope.of(context).unfocus();
                        if (widget.categoria == null) {
                          homeCubit.createCategoria(
                            categoriasModel: CategoriasModel(
                              idCategoria: '0',
                              nbCategoria: nbCategoriaController.text,
                            ),
                            context: context,
                          );
                        } else {
                          homeCubit.updateCategoria(
                            categoriasModel: CategoriasModel(
                              idCategoria: widget.categoria!.idCategoria,
                              nbCategoria: nbCategoriaController.text,
                            ),
                            context: context,
                          );
                        }
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
