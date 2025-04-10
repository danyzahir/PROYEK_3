import 'package:flutter/material.dart';


class AbsensiGuruPage extends StatelessWidget {
  final String username;

  const AbsensiGuruPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi Guru"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Selamat datang, $username!\nIni halaman Absensi Guru.',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
