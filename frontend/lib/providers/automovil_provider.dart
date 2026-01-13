import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/automovil_controller.dart';
import '../models/automovil.dart';

final automovilControllerProvider = Provider<AutomovilController>((ref) {
  return AutomovilController();
});

final automovilProvider =
    StateNotifierProvider<AutomovilNotifier, AsyncValue<List<Automovil>>>(
        (ref) {
  final controller = ref.read(automovilControllerProvider);
  return AutomovilNotifier(controller);
});

class AutomovilNotifier extends StateNotifier<AsyncValue<List<Automovil>>> {
  final AutomovilController _controller;

  AutomovilNotifier(this._controller) : super(const AsyncValue.loading()) {
    cargarAutomoviles();
  }

  Future<void> cargarAutomoviles() async {
    try {
      final automoviles = await _controller.getAutomoviles();
      state = AsyncValue.data(automoviles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> agregarAutomovil(Automovil automovil) async {
    try {
      await _controller.crearAutomovil(automovil);
      await cargarAutomoviles();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> eliminarAutomovil(int id) async {
    try {
      await _controller.eliminarAutomovil(id);
      await cargarAutomoviles();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
