import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghapus label debug
      title: 'Aplikasi Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Rute awal (login)
      routes: {
        '/': (context) => const LoginPage(), // Halaman login
        '/home': (context) => HomePage(), // Halaman utama
      },
    );
  }
}
