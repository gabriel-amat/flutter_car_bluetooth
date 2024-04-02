import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/pages/devices/devices_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DevicesPage(),
                    ),
                  );
                },
                title: const Text("Dispostivos"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
