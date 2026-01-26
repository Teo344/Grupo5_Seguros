/*
import '../models/propietario.dart';
import '../services/api_service.dart';

class PropietarioController {
  final ApiService _apiService = ApiService();

  /// Obtener propietarios
  Future<List<Propietario>> getPropietarios() async {
    try {
      return await _apiService.getPropietarios();
    } catch (e) {
      throw Exception('Error al obtener propietarios: $e');
    }
  }

  /// Crear propietario
  Future<Propietario> crearPropietario(Propietario propietario) async {
    try {
      return await _apiService.createPropietario(propietario);
    } catch (e) {
      throw Exception('Error al crear propietario: $e');
    }
  }

  /// Actualizar propietario
  Future<Propietario> actualizarPropietario(
      int id, Propietario propietario) async {
    try {
      return await _apiService.updatePropietario(id, propietario);
    } catch (e) {
      throw Exception('Error al actualizar propietario: $e');
    }
  }

  /// Eliminar propietario
  Future<void> eliminarPropietario(int id) async {
    try {
      await _apiService.deletePropietario(id);
    } catch (e) {
      throw Exception('Error al eliminar propietario: $e');
    }
  }
}
*/