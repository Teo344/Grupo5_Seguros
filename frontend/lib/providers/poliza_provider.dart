import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/poliza_request.dart';
import '../models/poliza_response.dart';
import 'api_provider.dart';
import 'poliza_busqueda_provider.dart';

final crearPolizaProvider =
    FutureProvider.family<PolizaResponse, PolizaRequest>((ref, request) async {

  final response = await ref.read(apiProvider).crearPoliza(request);

  // 🔥 invalidar búsquedas y listados
  ref.invalidate(todasPolizasProvider);
  ref.invalidate(buscarPolizaProvider);
  ref.invalidate(buscarPolizaIdProvider);

  return response;
});
