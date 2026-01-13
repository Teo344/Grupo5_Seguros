class Propietario {
  final int? id;
  final String nombre;
  final String cedula;
  final String telefono;

  Propietario({
    this.id,
    required this.nombre,
    required this.cedula,
    required this.telefono,
  });

  factory Propietario.fromJson(Map<String, dynamic> json) {
    return Propietario(
      id: json['id'],
      nombre: json['nombre'],
      cedula: json['cedula'],
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cedula': cedula,
      'telefono': telefono,
    };
  }
}
