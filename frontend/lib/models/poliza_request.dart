class PolizaRequest {
  final String propietario;
  final double valorSeguroAuto;
  final String modeloAuto;
  final int accidentes;
  final int edadPropietario;

  PolizaRequest({
    required this.propietario,
    required this.valorSeguroAuto,
    required this.modeloAuto,
    required this.accidentes,
    required this.edadPropietario,
  });

  Map<String, dynamic> toJson() => {
    "propietario": propietario,
    "valorSeguroAuto": valorSeguroAuto,
    "modeloAuto": modeloAuto,
    "accidentes": accidentes,
    "edadPropietario": edadPropietario,
  };
}
