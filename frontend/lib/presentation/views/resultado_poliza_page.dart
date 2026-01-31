import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/poliza_request.dart';
import 'package:frontend/providers/poliza_provider.dart';


class ResultadoPolizaPage extends ConsumerWidget {
  final PolizaRequest request;

  const ResultadoPolizaPage({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final polizaAsync = ref.watch(crearPolizaProvider(request));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado de la Póliza", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: polizaAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            "Error: $err",
            style: const TextStyle(color: Colors.red),
          ),
        ),
        data: (poliza) => Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item("Propietario", poliza.propietario),
                  _item("Modelo", poliza.modeloAuto),
                  _item("Valor del auto",
                      "\$${poliza.valorSeguroAuto.toStringAsFixed(2)}"),
                  _item("Edad", poliza.edadPropietario.toString()),
                  _item("Accidentes", poliza.accidentes.toString()),
                  const Divider(thickness: 1),
                  _item(
                    "Costo Total: ",
                    "\$${poliza.costoTotal.toStringAsFixed(2)}",
                    isTotal: true,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("VOLVER" ,style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 12,
              color: isTotal ? Colors.teal : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
