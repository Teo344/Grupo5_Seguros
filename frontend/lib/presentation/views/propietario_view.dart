import 'package:flutter/material.dart';
import '../../controllers/propietario_controller.dart';
import '../../models/propietario.dart';

class PropietarioView extends StatelessWidget {
  PropietarioView({super.key});

  final PropietarioController _controller = PropietarioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Propietarios'),
      ),
      body: FutureBuilder<List<Propietario>>(
        future: _controller.getPropietarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final propietarios = snapshot.data!;

          return ListView.builder(
            itemCount: propietarios.length,
            itemBuilder: (context, index) {
              final p = propietarios[index];
              return ListTile(
                title: Text(p.nombre),
                subtitle: Text('Cédula: ${p.cedula}'),
              );
            },
          );
        },
      ),
    );
  }
}
