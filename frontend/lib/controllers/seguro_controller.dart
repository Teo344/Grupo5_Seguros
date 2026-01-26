/*
import '../models/seguro.dart';
import '../services/api_service.dart';

class SeguroController {
  final ApiService _apiService = ApiService();

  /// Obtener seguros
  Future<List<Seguro>> getSeguros() async {
    try {
      return await _apiService.getSeguros();
    } catch (e) {
      throw Exception('Error al obtener seguros: $e');
    }
  }

  /// Crear seguro
  Future<Seguro> crearSeguro(Seguro seguro) async {
    try {
      return await _apiService.createSeguro(seguro);
    } catch (e) {
      throw Exception('Error al crear seguro: $e');
    }
  }

  /// Actualizar seguro
  Future<Seguro> actualizarSeguro(int id, Seguro seguro) async {
    try {
      return await _apiService.updateSeguro(id, seguro);
    } catch (e) {
      throw Exception('Error al actualizar seguro: $e');
    }
  }

  /// Eliminar seguro
  Future<void> eliminarSeguro(int id) async {
    try {
      await _apiService.deleteSeguro(id);
    } catch (e) {
      throw Exception('Error al eliminar seguro: $e');
    }
  }
}
*/
