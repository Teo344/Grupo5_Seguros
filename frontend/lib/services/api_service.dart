import 'dart:convert';
import 'package:frontend/models/poliza_request.dart';
import 'package:frontend/models/poliza_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://192.168.18.12:9090/bdd_dto/api";

  Future<PolizaResponse> crearPoliza(PolizaRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/poliza"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return PolizaResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear póliza");
    }
  }

  Future<PolizaResponse> buscarPolizaPorNombre(String nombre) async {
  final response = await http.get(
    Uri.parse("$baseUrl/poliza/usuario?nombre=$nombre"),
  );

  if (response.statusCode == 200) {
    return PolizaResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("No se encontró póliza para $nombre");
  }
}



  Future<List<PolizaResponse>> obtenerTodas() async {
    final response = await http.get(
      Uri.parse('$baseUrl/poliza/todas'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => PolizaResponse.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar pólizas");
    }
  }

  Future<PolizaResponse> buscarPorId(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/poliza/$id'),
    );

    if (response.statusCode == 200) {
      return PolizaResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Póliza no encontrada");
    }
  }

}
