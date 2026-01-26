import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controllers/poliza_controller.dart';

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
        title: const Text("Crear Póliza"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              /// PROPIETARIO
              TextFormField(
                controller: propietarioCtrl,
                decoration: const InputDecoration(
                  labelText: "Propietario",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Ingrese el nombre" : null,
              ),
              const SizedBox(height: 12),

              /// VALOR DEL AUTO
              TextFormField(
                controller: valorCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Valor del seguro",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Ingrese el valor" : null,
              ),
              const SizedBox(height: 20),

              /// MODELO
              const Text("Modelo de auto:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile(
                title: const Text("Modelo A"),
                value: "A",
                groupValue: modeloSeleccionado,
                onChanged: (v) => setState(() => modeloSeleccionado = v!),
              ),
              RadioListTile(
                title: const Text("Modelo B"),
                value: "B",
                groupValue: modeloSeleccionado,
                onChanged: (v) => setState(() => modeloSeleccionado = v!),
              ),
              RadioListTile(
                title: const Text("Modelo C"),
                value: "C",
                groupValue: modeloSeleccionado,
                onChanged: (v) => setState(() => modeloSeleccionado = v!),
              ),

              const SizedBox(height: 20),

              /// EDAD
              const Text("Edad propietario:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile(
                title: const Text("סהMayor o igual a 18 y menor a 24"),
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

              const SizedBox(height: 20),

              /// ACCIDENTES
              TextFormField(
                controller: accidentesCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Número de accidentes",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Ingrese accidentes" : null,
              ),

              const SizedBox(height: 30),

              /// BOTÓN
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: crearPoliza,
                child: const Text(
                  "CREAR PÓLIZA",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
