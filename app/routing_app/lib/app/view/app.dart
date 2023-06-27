import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/cubit/general_cubit.dart';
import 'package:routing_app/app/modules/categorias/view/home_page.dart';
import 'package:routing_app/app/modules/categorias/view/nueva_categoria_page.dart';
import 'package:routing_app/app/modules/paradas/view/nueva_parada_page.dart';
import 'package:routing_app/app/modules/paradas/view/paradas_page.dart';
import 'package:routing_app/app/modules/rutas/view/nueva_ruta_page.dart';
import 'package:routing_app/app/modules/rutas/view/rutas_page.dart';
import 'package:routing_app/core/singleton/dio_singleton.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
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
              theme: ThemeData(useMaterial3: true).copyWith(
                textTheme: textTheme,
                //cardColor: Colors.white,
                //text color

                cardTheme: CardTheme(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              //routes: routes(context: context),
              onGenerateRoute: getRoutes,
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

  Route<dynamic>? getRoutes(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/nueva_categoria':
        return MaterialPageRoute(
          builder: (context) => NuevaCategoriaPage(
            categoria: null,
          ),
        );

      case '/editar_categoria':
        return MaterialPageRoute(
          builder: (context) => NuevaCategoriaPage(
            categoria: settings.arguments['categoria'] as CategoriasModel,
          ),
        );
      case '/paradas':
        final arguments = settings.arguments! as Map;
        return MaterialPageRoute(
          builder: (context) => ParadasPage(
            categoria: arguments['categoria'] as CategoriasModel,
            ruta: arguments['ruta'] as RutasModel,
          ),
        );

      case '/nueva_ruta':
        return MaterialPageRoute(
          builder: (context) => NuevaRutaPage(
            ruta: null,
            categoria:
                (settings.arguments as Map)['categoria'] as CategoriasModel,
          ),
        );
      case '/rutas':
        return MaterialPageRoute(
          builder: (context) => RutasPage(
            categoria: settings.arguments['categoria'] as CategoriasModel,
          ),
        );
      case '/editar_ruta':
        return MaterialPageRoute(
          builder: (context) => NuevaRutaPage(
            ruta: (settings.arguments as Map)['ruta'] as RutasModel,
            categoria:
                (settings.arguments as Map)['categoria'] as CategoriasModel,
          ),
        );
      case '/nueva_parada':
        final arguments = settings.arguments! as Map;
        return MaterialPageRoute(
          builder: (context) => NuevaParadaPage(
            parada: null,
            ruta: arguments['ruta'] as RutasModel,
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
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
      '/rutas': (context) => RutasPage(
            categoria:
                ModalRoute.of(context)!.settings.arguments as CategoriasModel,
          ),
      '/nueva_ruta': (context) {
        return NuevaRutaPage(
          ruta: null,
          categoria:
              (ModalRoute.of(context)!.settings.arguments as Map)['categoria']
                  .value as CategoriasModel,
        );
      },
      'editar_ruta': (context) => NuevaRutaPage(
            ruta: (ModalRoute.of(context)!.settings.arguments as Map)['ruta']
                as RutasModel,
            categoria: (ModalRoute.of(context)!.settings.arguments
                as Map)['categoria'] as CategoriasModel,
          ),
    };
  }
}
