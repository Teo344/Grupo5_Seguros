import 'propietario.dart';
import 'seguro.dart';

class Automovil {
  final int? id;
  final String placa;
  final String marca;
  final String modelo;
  final Propietario propietario;
  final Seguro seguro;

  Automovil({
    this.id,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.propietario,
    required this.seguro,
  });

  factory Automovil.fromJson(Map<String, dynamic> json) {
    return Automovil(
      id: json['id'],
      placa: json['placa'],
      marca: json['marca'],
      modelo: json['modelo'],
      propietario: Propietario.fromJson(json['propietario']),
      seguro: Seguro.fromJson(json['seguro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placa': placa,
      'marca': marca,
      'modelo': modelo,
      'propietario': propietario.toJson(),
      'seguro': seguro.toJson(),
    };
  }
}
