import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth/shared/custom_notifications.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:rxdart/subjects.dart';

class BluetoothController {
  final snack = CustomSnack();
  final bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;

  final devices = BehaviorSubject<List<BluetoothDevice>?>.seeded([]);
  Stream<List<BluetoothDevice>?> get outDevices => devices.stream;

  final deviceConnected = BehaviorSubject<BluetoothDevice?>();
  Stream<BluetoothDevice?> get outDeviceConnected => deviceConnected.stream;

  Future<void> getDevices() async {
    snack.loading(text: "Carregando lista de dispositvos...");
    devices.add(null);
    devices.add(await bluetooth.getBondedDevices());
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    snack.loading(text: "Conectando ao dispositvo...");
    try {
      connection = await BluetoothConnection.toAddress(
        device.address,
      );
      deviceConnected.add(device);
    } on Exception catch (e) {
      debugPrint("ConnectToDevice error $e");
      snack.error(text: "Erro ao conectar no dispositivo $e");
    }
  }
}
