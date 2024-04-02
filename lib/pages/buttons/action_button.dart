import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    this.color = Colors.white,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(2, 2),
              color: Colors.grey,
            )
          ],
        ),
        child: Icon(icon, size: 40, color: Colors.white),
      ),
    );
  }
}
