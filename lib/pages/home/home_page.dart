import 'package:flutter_bluetooth/pages/home/widgets/bt_controll.dart';
import 'package:flutter_bluetooth/pages/home/widgets/bt_device_connected.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/pages/buttons/buttons_page.dart';
import 'widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter ❤️ Arduino'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const BluetoothControll(),
            const Expanded(child: BluetoothDeviceConnected()),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ButtonsPage()),
                );
              },
              child: const Text("Ver botões"),
            ),
          ],
        ),
      ),
    );
  }
}
