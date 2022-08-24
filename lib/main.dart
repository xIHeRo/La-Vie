import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/dependecy_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
