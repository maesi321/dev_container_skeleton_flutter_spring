import 'package:flutter/material.dart';
import 'content.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo project",
      home: Scaffold(
        appBar: AppBar(title: Text("Demo")),
        body: Center(child: Content()),
      ),
    );
  }
}
