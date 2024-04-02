import 'package:flutter_bluetooth/controllers/bluetooth_controller.dart';
import 'package:get_it/get_it.dart';

setupLocators() {
  GetIt.I.registerSingleton(BluetoothController());
}
