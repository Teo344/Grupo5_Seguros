import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/poliza_response.dart';
import 'api_provider.dart';

final todasPolizasProvider =
    FutureProvider<List<PolizaResponse>>((ref) {
  return ref.read(apiProvider).obtenerTodas();
});

final buscarPolizaProvider =
    FutureProvider.family<PolizaResponse, String>((ref, nombre) {
  return ref.read(apiProvider).buscarPolizaPorNombre(nombre);
});

final buscarPolizaIdProvider =
    FutureProvider.family<PolizaResponse, int>((ref, id) {
  return ref.read(apiProvider).buscarPorId(id);
});
