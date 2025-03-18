import 'package:flutter/material.dart';
import 'screens/login.dart'; 
import 'screens/home_screen.dart'; 
import 'screens/absensi.dart'; // Import halaman Absensi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/', // Mulai dari halaman Login
      routes: {
        '/': (context) => const LoginScreen(), // Halaman pertama
        '/home': (context) => const HomeScreen(), // Halaman Home setelah login
        '/absensi': (context) => const AbsensiScreen(), // Tambahkan route ke Absensi
      },
    );
  }
}
