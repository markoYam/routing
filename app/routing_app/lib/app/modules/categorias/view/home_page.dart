import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/modules/categorias/cubit/categorias_cubit.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/data/model/categorias_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late CategoriasCubit homeCubit;
late BuildContext context2;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context2 = context;
    return BlocProvider(
      create: (context) => CategoriasCubit()..getCategorias(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categorías'),
          centerTitle: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<CategoriasCubit, HomeState>(
              builder: (context, state) {
                homeCubit = context.read<CategoriasCubit>();
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: getItemCategoria(context, categoria),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
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

  SizedBox getItemCategoria(BuildContext context, CategoriasModel categoria) {
    return SizedBox(
      height: ResponsiveSingleton.ip * 0.1,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/rutas',
              arguments: <String, dynamic>{
                'categoria': categoria,
              },
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
                  Icons.local_activity,
                  size: ResponsiveSingleton.ip * 0.03,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  categoria.nbCategoria,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editar_categoria',
                        arguments: <String, dynamic>{
                          'categoria': categoria,
                        }).then(
                      (value) => homeCubit.getCategorias(),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    //color: Colors.white,
                    size: ResponsiveSingleton.ip * 0.03,
                  ),
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
                  icon: Icon(
                    Icons.delete,
                    //color: Colors.white,
                    size: ResponsiveSingleton.ip * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitleMaterial() {
    return Text(
      'Categorías',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
