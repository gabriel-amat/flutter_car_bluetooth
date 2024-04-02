import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get_it/get_it.dart';

import '../../../controllers/bluetooth_controller.dart';

class BluetoothControll extends StatefulWidget {
  const BluetoothControll({super.key});

  @override
  State<BluetoothControll> createState() => _BluetoothControllState();
}

class _BluetoothControllState extends State<BluetoothControll> {
  final bluetoothController = GetIt.I.get<BluetoothController>();
  bool bluetoothEnable = false;

  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());

    bluetoothController.bluetooth.onStateChanged().listen((state) {
      debugPrint("Bluetooth state $state");
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => bluetoothEnable = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => bluetoothEnable = true);
          break;
      }
    });
    super.initState();
  }

  loadData() async {
    bluetoothEnable = await bluetoothController.bluetooth.isEnabled ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SwitchListTile.adaptive(
          value: bluetoothEnable,
          onChanged: (bool value) async {
            if (value) {
              await bluetoothController.bluetooth.requestEnable();
            } else {
              await bluetoothController.bluetooth.requestDisable();
            }
            setState(() => bluetoothEnable = value);
          },
          title: Text(
            bluetoothEnable ? "Bluetooth ativado" : "Bluetooth desativado",
          ),
        ),
      ),
    );
  }
}
