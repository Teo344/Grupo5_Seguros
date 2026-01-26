import 'dart:convert';
import 'package:frontend/models/poliza_request.dart';
import 'package:frontend/models/poliza_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://10.40.11.243:9090/bdd_dto/api";

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
}
