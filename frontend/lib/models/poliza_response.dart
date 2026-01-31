class PolizaResponse {
  final String propietario;
  final String modeloAuto;
  final double valorSeguroAuto;
  final int edadPropietario;
  final int accidentes;
  final double costoTotal;

  PolizaResponse({
    required this.propietario,
    required this.modeloAuto,
    required this.valorSeguroAuto,
    required this.edadPropietario,
    required this.accidentes,
    required this.costoTotal,
  });

  factory PolizaResponse.fromJson(Map<String, dynamic> json) {
    return PolizaResponse(
      propietario: json['propietario'],
      modeloAuto: json['modeloAuto'],
      valorSeguroAuto: json['valorSeguroAuto'].toDouble(),
      edadPropietario: json['edadPropietario'],
      accidentes: json['accidentes'],
      costoTotal: json['costoTotal'].toDouble(),
    );
  }
}
