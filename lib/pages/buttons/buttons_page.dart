import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth/pages/buttons/action_button.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/bluetooth_controller.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  final bluetoothController = GetIt.I.get<BluetoothController>();
  bool farol = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  void sendData(String data) {
    debugPrint("Send data");
    debugPrint("Data ${ascii.encode(data)}");
    if (bluetoothController.connection?.isConnected ?? false) {
      bluetoothController.connection?.output.add(ascii.encode(data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Controles"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => farol = !farol);
              if (farol) {
                sendData("10");
              } else {
                sendData("11");
              }
            },
            iconSize: 35,
            icon: farol
                ? const Icon(Icons.lightbulb, color: Colors.amber)
                : const Icon(Icons.lightbulb_outline),
          ),
          IconButton(
            onPressed: () => sendData("s"),
            iconSize: 35,
            icon: const Icon(Icons.audiotrack_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Left / Right
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ActionButton(
                          icon: Icons.keyboard_arrow_left_rounded,
                          color: Colors.amber,
                          onTap: () => sendData("l"),
                        ),
                        const SizedBox(width: 22),
                        ActionButton(
                          icon: Icons.keyboard_arrow_right_rounded,
                          color: Colors.amber,
                          onTap: () => sendData("r"),
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: () => sendData('s'),
                      child: Image.asset(
                        "assets/icons/stop_sign.png",
                        height: 80,
                      ),
                    ),

                    //Forward / back
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          icon: Icons.keyboard_arrow_up_rounded,
                          color: Colors.green,
                          onTap: () => sendData("f"),
                        ),
                        const SizedBox(height: 22),
                        ActionButton(
                          icon: Icons.keyboard_arrow_down_rounded,
                          color: Colors.red,
                          onTap: () => sendData("b"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
