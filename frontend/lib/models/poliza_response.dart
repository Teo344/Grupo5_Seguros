class PolizaResponse {
  final String propietario;
  final String modeloAuto;
  final double valorSeguroAuto;
  final int edadPropietario;
  final int accidentes;
  final double costoTotal;

  PolizaResponse.fromJson(Map<String, dynamic> json)
      : propietario = json['propietario'],
        modeloAuto = json['modeloAuto'],
        valorSeguroAuto = json['valorSeguroAuto'],
        edadPropietario = json['edadPropietario'],
        accidentes = json['accidentes'],
        costoTotal = json['costoTotal'];
}
