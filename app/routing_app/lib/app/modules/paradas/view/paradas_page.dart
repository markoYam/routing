import 'package:flutter/material.dart';
import 'package:routing_app/data/model/categorias_model.dart';

class ParadasPage extends StatefulWidget {
  const ParadasPage({
    super.key,
    required this.categoria,
  });

  final CategoriasModel categoria;

  @override
  State<ParadasPage> createState() => _ParadasPageState();
}

class _ParadasPageState extends State<ParadasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoria.nbCategoria}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
  }
}
