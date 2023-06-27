import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/app/modules/rutas/cubit/rutas_cubit.dart';
import 'package:routing_app/core/utils/utils.dart';
import 'package:routing_app/data/model/categorias_model.dart';
import 'package:routing_app/data/model/rutas_model.dart';
import 'package:routing_app/widgets/custom_button_widget.dart';
import 'package:routing_app/widgets/custom_drop_down_button.dart';
import 'package:routing_app/widgets/text_field_outline.dart';

class NuevaRutaPage extends StatefulWidget {
  const NuevaRutaPage({super.key, this.ruta, required this.categoria});

  final RutasModel? ruta;
  final CategoriasModel categoria;

  @override
  State<NuevaRutaPage> createState() => _NuevaRutaPageState();
}

class _NuevaRutaPageState extends State<NuevaRutaPage> {
  final TextEditingController _nbRuteoController = TextEditingController();
  final TextEditingController _fhEntregaController = TextEditingController();
  int? _selectedStatus = 1;
  final itemsStatus = [
    DropdownMenuItem(
      child: Text('Activo'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Inactivo'),
      value: 7,
    ),
  ];

  Future<void> _guardar({required BuildContext ctx}) async {
    final RutasModel ruta = RutasModel(
      nbRuteo: _nbRuteoController.text,
      idEstatus: (_selectedStatus ?? 1).toString(),
      feEntrega: _fhEntregaController.text,
      idCategoria: widget.categoria.idCategoria,
      feRegistro: DateTime.now().toshortString(),
      idRuteo: widget.ruta?.idRuteo ?? '0',
      numParadas: '0',
      categoria: widget.categoria,
    );
    print(ruta);
    if (widget.ruta == null) {
      _rutasCubit.createRuta(ruta: ruta, ctx: ctx);
    } else {
      _rutasCubit.updateRuta(ruta: ruta, ctx: ctx);
    }
  }

  late RutasCubit _rutasCubit;
  bool isFirstTime = true;

  void init() {
    if (!isFirstTime) return;

    if (widget.ruta != null) {
      _nbRuteoController.text = widget.ruta!.nbRuteo;
      _fhEntregaController.text = widget.ruta!.feEntrega;
      _selectedStatus = int.parse(widget.ruta!.idEstatus);
    } else if (isFirstTime) {
      _nbRuteoController.text = '';
      _fhEntregaController.text = DateTime.now().toshortString();
      _selectedStatus = 1;
    }

    isFirstTime = false;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return BlocProvider(
      create: (context) => RutasCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nueva Ruta'),
          centerTitle: false,
        ),
        body: BlocBuilder<RutasCubit, RutasState>(
          builder: (context, state) {
            _rutasCubit = context.read<RutasCubit>();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldOutLine(
                    hintText: 'Nombre',
                    controller: _nbRuteoController,
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  CustomDropDownButton(
                    selectedValue: _selectedStatus ?? 1,
                    lsItemsStatus: itemsStatus,
                    hintText: 'Seleccione un estatus',
                    onChanged: (int? value) {
                      print(value);
                      _selectedStatus = value;
                    },
                    prefixIcon: Icons.traffic_outlined,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldOutLine(
                          hintText: 'Fecha Entrega',
                          controller: _fhEntregaController,
                          isEnable: false,
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDatePickerMaterial(context);
                        },
                        icon: Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  if (state.status == RutasStatus.loading)
                    CircularProgressIndicator()
                  else
                    CustomButtonWidget(
                      hintText: 'Guardar',
                      onPressed: () {
                        _guardar(ctx: context);
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

  void showDatePickerMaterial(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    ).then((value) {
      if (value != null) {
        setState(() {
          //String formattedDate = DateFormat('yyyy-MM-dd').format(value);
          //print(formattedDate);
          _fhEntregaController.text = value.toshortString();
        });
      }
    });
  }
}
