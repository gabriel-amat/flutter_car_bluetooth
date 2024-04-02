import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get_it/get_it.dart';

import '../../../controllers/bluetooth_controller.dart';

class BluetoothDeviceConnected extends StatelessWidget {
  const BluetoothDeviceConnected({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothController = GetIt.I.get<BluetoothController>();
    return StreamBuilder<BluetoothDevice?>(
      stream: bluetoothController.outDeviceConnected,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "Nenhum dispositivo conectado no momento",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          );
        }
        return ListTile(
          tileColor: Colors.black12,
          title: Text(
            "Conectado a: ${snapshot.data!.name ?? "Nenhum"}",
          ),
          trailing: snapshot.data!.isConnected
              ? TextButton(
                  onPressed: () async {
                    await bluetoothController.connection?.finish();
                    bluetoothController.deviceConnected.sink.add(null);
                  },
                  child: const Text("Desconectar"),
                )
              : const Text("Não conectado"),
        );
      },
    );
  }
}
