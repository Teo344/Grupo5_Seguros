import '../models/poliza_request.dart';

class PolizaController {
  PolizaRequest buildRequest({
    required String propietario,
    required double valor,
    required String modelo,
    required int accidentes,
    required int edad,
  }) {
    return PolizaRequest(
      propietario: propietario,
      valorSeguroAuto: valor,
      modeloAuto: modelo,
      accidentes: accidentes,
      edadPropietario: edad,
    );
  }
}
