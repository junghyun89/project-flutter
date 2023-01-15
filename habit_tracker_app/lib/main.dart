import 'package:flutter/material.dart';
import 'package:habit_tracker_app/models/task_model.dart';
import 'package:habit_tracker_app/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.ubuntu().fontFamily),
      home: const HomePage(),
    );
  }
}
