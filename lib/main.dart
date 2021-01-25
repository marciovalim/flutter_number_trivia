import 'package:flutter/material.dart';
import 'package:flutter_number_trivia/app.dart';
import 'package:flutter_number_trivia/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Di.setup();
  runApp(App());
}
