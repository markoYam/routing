import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/cubit/general_cubit.dart';
import 'package:routing_app/app/modules/home/view/home_page.dart';
import 'package:routing_app/app/modules/home/view/nueva_categoria_page.dart';
import 'package:routing_app/app/modules/paradas/view/paradas_page.dart';
import 'package:routing_app/app/modules/rutas/view/rutas_page.dart';
import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/counter/counter.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/l10n/l10n.dart';
import 'package:routing_app/widgets/text_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});
  void initSingleton({required BuildContext buildContext}) {
    ResponsiveSingleton.init(context: buildContext);
    DioSingleton.createDio();
    log("ip: ${ResponsiveSingleton.ip}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralCubit(),
      child: BlocBuilder<GeneralCubit, GeneralState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Routing App',
              themeMode: ThemeMode.light,
              theme: ThemeData(useMaterial3: true, textTheme: textTheme),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routes: routes(context: context),
              builder: (context, child) {
                initSingleton(buildContext: context);
                return child!;
              }
              // home: const CounterPage(),
              );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> routes({required BuildContext context}) {
    return {
      '/': (context) => const HomePage(),
      '/nueva_categoria': (context) => NuevaCategoriaPage(
            categoria: null,
          ),
      '/editar_categoria': (context) => NuevaCategoriaPage(
            categoria:
                ModalRoute.of(context)!.settings.arguments as CategoriasModel,
          ),
      '/paradas': (context) => ParadasPage(
            categoria:
                ModalRoute.of(context)!.settings.arguments as CategoriasModel,
          ),
      '/rutas': (context) => RutasPage(
            categoria:
                ModalRoute.of(context)!.settings.arguments as CategoriasModel,
          ),
    };
  }
}
