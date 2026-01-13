import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/automovil.dart';
import '../models/propietario.dart';
import '../models/seguro.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  /* ================= AUTOMOVIL ================= */

  Future<List<Automovil>> getAutomoviles() async {
    final response = await http.get(Uri.parse('$baseUrl/automovil'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Automovil.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener automóviles');
    }
  }

  Future<Automovil> createAutomovil(Automovil automovil) async {
    final response = await http.post(
      Uri.parse('$baseUrl/automovil'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(automovil.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Automovil.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear automóvil');
    }
  }

  Future<Automovil> updateAutomovil(int id, Automovil automovil) async {
    final response = await http.put(
      Uri.parse('$baseUrl/automovil/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(automovil.toJson()),
    );

    if (response.statusCode == 200) {
      return Automovil.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar automóvil');
    }
  }

  Future<void> deleteAutomovil(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/automovil/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar automóvil');
    }
  }

  /* ================= PROPIETARIO ================= */

  Future<List<Propietario>> getPropietarios() async {
    final response = await http.get(Uri.parse('$baseUrl/propietario'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Propietario.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener propietarios');
    }
  }

  Future<Propietario> createPropietario(Propietario propietario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/propietario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(propietario.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Propietario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear propietario');
    }
  }

  Future<Propietario> updatePropietario(
      int id, Propietario propietario) async {
    final response = await http.put(
      Uri.parse('$baseUrl/propietario/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(propietario.toJson()),
    );

    if (response.statusCode == 200) {
      return Propietario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar propietario');
    }
  }

  Future<void> deletePropietario(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/propietario/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar propietario');
    }
  }

  /* ================= SEGURO ================= */

  Future<List<Seguro>> getSeguros() async {
    final response = await http.get(Uri.parse('$baseUrl/seguro'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Seguro.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener seguros');
    }
  }

  Future<Seguro> createSeguro(Seguro seguro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/seguro'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(seguro.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Seguro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear seguro');
    }
  }

  Future<Seguro> updateSeguro(int id, Seguro seguro) async {
    final response = await http.put(
      Uri.parse('$baseUrl/seguro/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(seguro.toJson()),
    );

    if (response.statusCode == 200) {
      return Seguro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al actualizar seguro');
    }
  }

  Future<void> deleteSeguro(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/seguro/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar seguro');
    }
  }
}
