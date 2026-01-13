import '../models/automovil.dart';
import '../services/api_service.dart';

class AutomovilController {
  final ApiService _apiService = ApiService();

  /// Obtener lista de automóviles
  Future<List<Automovil>> getAutomoviles() async {
    try {
      return await _apiService.getAutomoviles();
    } catch (e) {
      throw Exception('Error al obtener automóviles: $e');
    }
  }

  /// Crear un nuevo automóvil
  Future<Automovil> crearAutomovil(Automovil automovil) async {
    try {
      return await _apiService.createAutomovil(automovil);
    } catch (e) {
      throw Exception('Error al crear automóvil: $e');
    }
  }

  /// Actualizar automóvil
  Future<Automovil> actualizarAutomovil(int id, Automovil automovil) async {
    try {
      return await _apiService.updateAutomovil(id, automovil);
    } catch (e) {
      throw Exception('Error al actualizar automóvil: $e');
    }
  }

  /// Eliminar automóvil
  Future<void> eliminarAutomovil(int id) async {
    try {
      await _apiService.deleteAutomovil(id);
    } catch (e) {
      throw Exception('Error al eliminar automóvil: $e');
    }
  }
}
