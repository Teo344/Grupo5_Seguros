import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/poliza_response.dart';

import '../../providers/poliza_busqueda_provider.dart';

class BuscarPolizaPage extends ConsumerStatefulWidget {
  const BuscarPolizaPage({super.key});

  @override
  ConsumerState<BuscarPolizaPage> createState() =>
      _BuscarPolizaPageState();
}

class _BuscarPolizaPageState
    extends ConsumerState<BuscarPolizaPage> {

  final TextEditingController idCtrl = TextEditingController();
  int? idBuscado;

  @override
  Widget build(BuildContext context) {
    final todasAsync = ref.watch(todasPolizasProvider);
    final polizaAsync = idBuscado == null
        ? null
        : ref.watch(buscarPolizaIdProvider(idBuscado!));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pólizas",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ================= BUSCADOR =================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: idCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "ID del automóvil",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.search, color: Colors.white),
                          label: const Text("Buscar", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              idBuscado =
                                  int.tryParse(idCtrl.text);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        label: const Text("Ver todas"),
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          setState(() {
                            idBuscado = null;
                            idCtrl.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ================= TITULO RESULTADOS =================
            Row(
              children: const [
                Icon(Icons.description_outlined,
                    color: Colors.grey),
                SizedBox(width: 6),
                Text(
                  "Resultados",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// ================= RESULTADOS =================
            Expanded(
              child: idBuscado != null
                  ? polizaAsync!.when(
                      loading: () => const Center(
                          child: CircularProgressIndicator()),
                      error: (e, _) => _errorState(
                          "Póliza no encontrada"),
                      data: (p) => ListView(
                        children: [_polizaCard(p)],
                      ),
                    )
                  : todasAsync.when(
                      loading: () => const Center(
                          child: CircularProgressIndicator()),
                      error: (e, _) =>
                          _errorState("Error al cargar pólizas"),
                      data: (lista) {
                        if (lista.isEmpty) {
                          return _emptyState(
                              "No existen pólizas registradas");
                        }
                        return ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (_, i) =>
                              _polizaCard(lista[i]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= CARD =================
  Widget _polizaCard(PolizaResponse p) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Row(
              children: [
                const Icon(Icons.person, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  p.propietario,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            _item(Icons.directions_car, "Modelo", p.modeloAuto),
            _item(Icons.attach_money, "Valor",
                p.valorSeguroAuto.toString()),
            _item(Icons.cake, "Edad",
                p.edadPropietario.toString()),
            _item(Icons.warning_amber, "Accidentes",
                p.accidentes.toString()),

            const SizedBox(height: 10),

            /// TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Costo total",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${p.costoTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= ITEM =================
  Widget _item(
      IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text("$label: ",
              style:
                  const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  /// ================= STATES =================
  Widget _emptyState(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined,
              size: 64, color: Colors.grey),
          const SizedBox(height: 10),
          Text(text,
              style:
                  const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _errorState(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 64, color: Colors.red),
          const SizedBox(height: 10),
          Text(text,
              style:
                  const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
