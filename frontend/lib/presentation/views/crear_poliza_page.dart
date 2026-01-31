import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controllers/poliza_controller.dart';
import 'package:flutter/services.dart';

import 'resultado_poliza_page.dart';

class CrearPolizaPage extends ConsumerStatefulWidget {
  const CrearPolizaPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CrearPolizaPage> createState() => _CrearPolizaPageState();
}

class _CrearPolizaPageState extends ConsumerState<CrearPolizaPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PolizaController();

  final TextEditingController propietarioCtrl = TextEditingController();
  final TextEditingController valorCtrl = TextEditingController();
  final TextEditingController accidentesCtrl = TextEditingController();

  String modeloSeleccionado = "A";
  int edadSeleccionada = 18;

  void crearPoliza() {
    if (_formKey.currentState!.validate()) {
      final request = _controller.buildRequest(
        propietario: propietarioCtrl.text,
        valor: double.parse(valorCtrl.text),
        modelo: modeloSeleccionado,
        accidentes: int.parse(accidentesCtrl.text),
        edad: edadSeleccionada,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadoPolizaPage(request: request),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Página de Seguros",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// DATOS DEL PROPIETARIO
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person, color: Colors.teal),
                          SizedBox(width: 8),
                          Text(
                            "Datos del propietario",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      TextFormField(
                        controller: propietarioCtrl,
                        decoration: const InputDecoration(
                          labelText: "Propietario",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? "Ingrese el nombre" : null,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// DATOS DEL VEHÍCULO
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.directions_car, color: Colors.teal),
                          SizedBox(width: 8),
                          Text(
                            "Datos del vehículo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      TextFormField(
                        controller: valorCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        decoration: const InputDecoration(
                          labelText: "Valor del seguro",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Ingrese el valor";
                          }
                          if (double.tryParse(v) == null) {
                            return "Ingrese solo números";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        "Modelo de auto",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RadioListTile(
                        title: const Text("Modelo A"),
                        value: "A",
                        groupValue: modeloSeleccionado,
                        onChanged: (v) =>
                            setState(() => modeloSeleccionado = v!),
                      ),
                      RadioListTile(
                        title: const Text("Modelo B"),
                        value: "B",
                        groupValue: modeloSeleccionado,
                        onChanged: (v) =>
                            setState(() => modeloSeleccionado = v!),
                      ),
                      RadioListTile(
                        title: const Text("Modelo C"),
                        value: "C",
                        groupValue: modeloSeleccionado,
                        onChanged: (v) =>
                            setState(() => modeloSeleccionado = v!),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PERFIL DEL PROPIETARIO
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.cake, color: Colors.teal),
                          SizedBox(width: 8),
                          Text(
                            "Perfil del propietario",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        "Edad del propietario",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RadioListTile(
                        title: const Text("Mayor o igual a 18 y menor a 24"),
                        value: 18,
                        groupValue: edadSeleccionada,
                        onChanged: (v) => setState(() => edadSeleccionada = v!),
                      ),
                      RadioListTile(
                        title: const Text("Mayor o igual a 24 y menor a 53"),
                        value: 24,
                        groupValue: edadSeleccionada,
                        onChanged: (v) => setState(() => edadSeleccionada = v!),
                      ),
                      RadioListTile(
                        title: const Text("Mayor o igual a 53"),
                        value: 53,
                        groupValue: edadSeleccionada,
                        onChanged: (v) => setState(() => edadSeleccionada = v!),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// HISTORIAL
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.teal),
                          SizedBox(width: 8),
                          Text(
                            "Historial",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      TextFormField(
                        controller: accidentesCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: "Número de accidentes",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Ingrese accidentes";
                          }
                          if (int.tryParse(v) == null) {
                            return "Ingrese solo números enteros";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// BOTÓN
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: crearPoliza,
                child: const Text(
                  "CREAR PÓLIZA",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
