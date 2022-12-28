import 'package:flutter/material.dart';
import 'package:service_deneme/service/service_learn_post_view.dart';
import 'package:service_deneme/service/service_learn_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const ServiceLearn(),
    );
  }
}
