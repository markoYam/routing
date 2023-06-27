// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing_app/app/modules/paradas/cubit/paradas_cubit.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/paradas_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ParadasPage extends StatefulWidget {
  const ParadasPage({
    super.key,
    required this.categoria,
    required this.ruta,
  });

  final CategoriasModel categoria;
  final RutasModel ruta;

  @override
  State<ParadasPage> createState() => _ParadasPageState();
}

class _ParadasPageState extends State<ParadasPage> {
  GoogleMapController? _mapController;

  late ParadasCubit _paradasCubit;
  var isFirst = true;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ParadasCubit()
            ..init(ruta: widget.ruta)
            ..getParadas(context: context),
        ),
      ],
      child: BlocBuilder<ParadasCubit, ParadasState>(
        builder: (context, state) {
          _paradasCubit = context.read<ParadasCubit>();
          if (isFirst && state.lsMarkers.isNotEmpty) {
            final position = state.lsMarkers.first.position;
            _mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15,
                ),
              ),
            );
            isFirst = false;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Paradas - ${widget.ruta.nbRuteo}'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/nueva_parada',
                  arguments: {
                    'categoria': widget.categoria,
                    'ruta': widget.ruta,
                  },
                ).then((value) => _paradasCubit.getParadas(context: context));
              },
              child: Icon(Icons.add),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: state.lsMarkers.toSet(),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.20672301755242, -89.28467170250686),
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Parada #10',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Descripción',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '\$ 20,200 ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: 40,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.check_circle_outlined,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 40,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 40,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.directions_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.map),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.list),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.list),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getDetailMarker({
    required BuildContext context,
    required ParadasModel parada,
  }) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset.zero,
            ),
          ],
          color: Colors.white,
        ),
        child: Container(),
      ),
    );
  }

  void openNavigation({
    required BuildContext context,
    required ParadasModel parada,
  }) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${parada.dcLatitud},${parada.dcLongitud}&travelmode=driving';
    final can = await canLaunch(url);
    if (can) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir la ruta'),
        ),
      );
    }
  }
}
