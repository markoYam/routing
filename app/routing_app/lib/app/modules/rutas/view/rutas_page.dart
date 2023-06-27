import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:routing_app/app/modules/rutas/cubit/rutas_cubit.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';

class RutasPage extends StatefulWidget {
  const RutasPage({super.key, required this.categoria});
  final CategoriasModel categoria;
  @override
  State<RutasPage> createState() => _RutasPageState();
}

class _RutasPageState extends State<RutasPage> {
  late RutasCubit rutasCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RutasCubit()
        ..init(categoria: widget.categoria)
        ..getRutas(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rutas - ${widget.categoria.nbCategoria}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/nueva_ruta',
              arguments: {
                'categoria': widget.categoria,
              },
            ).then((value) => rutasCubit.getRutas());
          },
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<RutasCubit, RutasState>(
          builder: (context, state) {
            rutasCubit = context.read<RutasCubit>();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: state.lsRutas.length,
                itemBuilder: (context, index) {
                  final ruta = state.lsRutas[index];
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: DrawerMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.pushNamed(
                            context,
                            '/editar_ruta',
                            arguments: {
                              'categoria': widget.categoria,
                              'ruta': ruta,
                            },
                          ).then((value) => rutasCubit.getRutas());
                        },
                        backgroundColor: Color(0xFF0392CF),
                        icon: Icons.edit,
                        //label: 'Editar',
                      ),
                      SlidableAction(
                        onPressed: (ctx) {
                          rutasCubit.deleteRuta(ruta: ruta, ctx: context);
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        //label: 'Eliminar',
                      ),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: getItemRuta(context, ruta, state, index),
                    ),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }

  InkWell getItemRuta(
    BuildContext context,
    RutasModel ruta,
    RutasState state,
    int index,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/paradas',
          arguments: <String, dynamic>{
            'ruta': ruta,
            'categoria': widget.categoria,
          },
        ).then((value) => rutasCubit.getRutas());
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: ResponsiveSingleton.ip * 0.05,
                    color: (ruta.idEstatus.toInt() == 1)
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(
                    width: ResponsiveSingleton.height * 0.01,
                  ),
                  Expanded(
                    child: Text(state.lsRutas[index].nbRuteo,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontSize: ResponsiveSingleton.proportionalFont(
                                18,
                              ),
                              color: (ruta.idEstatus.toInt() == 1)
                                  ? Colors.green
                                  : Colors.red,
                            )),
                  ),
                  SizedBox(
                    width: ResponsiveSingleton.ip * 0.04,
                    height: ResponsiveSingleton.ip * 0.04,
                    child: Badge(
                      label: Center(
                        child: Text(
                          state.lsRutas[index].numParadas.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveSingleton.proportionalFont(
                              17,
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveSingleton.height * 0.01,
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveSingleton.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Registro : ${ruta.getFechaCortaRegistro()}",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Entrega : ${ruta.getFechaCortaEntrega()}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
