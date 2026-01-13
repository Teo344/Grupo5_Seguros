class Seguro {
  final int? id;
  final String nombre;
  final String cobertura;
  final double costo;

  Seguro({
    this.id,
    required this.nombre,
    required this.cobertura,
    required this.costo,
  });

  factory Seguro.fromJson(Map<String, dynamic> json) {
    return Seguro(
      id: json['id'],
      nombre: json['nombre'],
      cobertura: json['cobertura'],
      costo: (json['costo'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cobertura': cobertura,
      'costo': costo,
    };
  }
}
