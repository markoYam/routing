import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/modules/home/cubit/home_cubit.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late HomeCubit homeCubit;
late BuildContext context2;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context2 = context;
    return BlocProvider(
      create: (context) => HomeCubit()..getCategorias(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categorías'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            homeCubit = context.read<HomeCubit>();
            if (state.status == HomeStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: state.categorias.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final categoria = state.categorias[index];
                    return SizedBox(
                      height: ResponsiveSingleton.ip * 0.1,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/rutas',
                              arguments: categoria,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                              ),
                              Expanded(
                                child: Icon(
                                  Icons.category,
                                  size: 40,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  categoria.nbCategoria,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/editar_categoria',
                                      arguments: categoria,
                                    ).then(
                                      (value) => homeCubit.getCategorias(),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    //eliminar
                                    homeCubit.deleteCategoria(
                                      categoriasModel: categoria,
                                      context2: context2,
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/nueva_categoria').then(
              (value) => homeCubit.getCategorias(),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
