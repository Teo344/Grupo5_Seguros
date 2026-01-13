import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/automovil_provider.dart';
import '../../models/automovil.dart';

class AutomovilView extends ConsumerWidget {
  const AutomovilView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final automovilState = ref.watch(automovilProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Automóviles'),
      ),
      body: automovilState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (automoviles) => ListView.builder(
          itemCount: automoviles.length,
          itemBuilder: (context, index) {
            final Automovil auto = automoviles[index];
            return ListTile(
              title: Text('${auto.marca} ${auto.modelo}'),
              subtitle: Text(
                'Placa: ${auto.placa}\nPropietario: ${auto.propietario.nombre}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref
                      .read(automovilProvider.notifier)
                      .eliminarAutomovil(auto.id!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
