import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/api_service.dart';
import '../models/poliza_request.dart';
import '../models/poliza_response.dart';

final apiProvider = Provider((ref) => ApiService());

final polizaProvider = FutureProvider.family<PolizaResponse, PolizaRequest>((ref, request) {
  return ref.read(apiProvider).crearPoliza(request);
});
