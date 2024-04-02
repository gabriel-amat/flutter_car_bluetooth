import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/bluetooth_controller.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothController = GetIt.I.get<BluetoothController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Dispostivos"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<BluetoothDevice>?>(
        stream: bluetoothController.outDevices,
        builder: (context, list) {
          if (!list.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (list.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Nenhum dispostivo encontrado"),
                  TextButton(
                    onPressed: bluetoothController.getDevices,
                    child: const Text("Procurar dispositivos"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.data!.length,
            itemBuilder: (context, index) {
              final device = list.data![index];

              return ListTile(
                title: Text(device.name ?? device.address),
                trailing: TextButton(
                  child: const Text('conectar'),
                  onPressed: () async {
                    bluetoothController.connectToDevice(device);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
