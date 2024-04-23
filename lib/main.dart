import 'package:flutter/material.dart';
import 'package:latihan1_jamil002/ui/bio.dart';
import 'package:latihan1_jamil002/ui/crud.dart';
import 'package:latihan1_jamil002/ui/galery.dart';
import 'package:latihan1_jamil002/ui/home.dart';
import 'package:latihan1_jamil002/ui/login.dart';
import 'package:latihan1_jamil002/ui/maps.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Latihan Mobile 1",
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/home' : (context) => const Home(),
        '/bio' : (context) => const Bio(),
        '/galery' : (context) => const Galery(),
        '/map' : (context) => const Maps(),
        '/crud' : (context) => const Crud(),
        '/login' : (context) => const Login(),
      },
    );
  }
}
