import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/config/locator.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocators();

  runApp(const MainApp());
}
