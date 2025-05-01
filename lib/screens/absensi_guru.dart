import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';
import 'absensi.dart';
import 'nilai.dart';
import 'data_guru_anak.dart';
import 'rekap_absensi.dart';

class AbsensiGuruPage extends StatefulWidget {
  final String username; // Menambahkan username untuk digunakan dalam navigasi

  const AbsensiGuruPage({super.key, required this.username});

  @override
  State<AbsensiGuruPage> createState() => _AbsensiGuruPageState();
}

class _AbsensiGuruPageState extends State<AbsensiGuruPage> {
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _openCamera(); // Otomatis buka kamera saat halaman dimuat
    });
  }

  Future<void> _openCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _capturedImage = File(photo.path);
        });
      }
    } catch (e) {
      // Menangani error apabila izin kamera ditolak atau ada masalah lain
      print('Error opening camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        children: [
          // Header Hijau
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          widget.username,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "ABSENSI",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Grid Menu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  // Box untuk kamera hasil
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.2,
                      children: [
                        _capturedImage != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: FileImage(_capturedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : _menuItem("Kamera", Icons.camera),
                      ],
                    ),
                  ),
                  // Tombol Capture
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.361,
                        child: GestureDetector(
                          onTap: _openCamera,
                          child: _menuItem("Capture", Icons.camera_alt),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Bottom Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(username: widget.username),
                      ),
                    );
                  },
                  child: _bottomNavItem("Dashboard", Icons.home, false),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AbsensiScreen(username: widget.username),
                      ),
                    );
                  },
                  child: _bottomNavItem(
                      "Absensi", Icons.assignment_ind_rounded, true),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NilaiScreen(username: widget.username),
                      ),
                    );
                  },
                  child: _bottomNavItem(
                      "Nilai", Icons.my_library_books_rounded, false),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DataScreen(username: widget.username),
                      ),
                    );
                  },
                  child:
                      _bottomNavItem("Data Guru & Anak", Icons.person, false),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RekapScreen(username: widget.username),
                      ),
                    );
                  },
                  child: _bottomNavItem(
                      "Rekap Absensi", Icons.receipt_long, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menu item
  Widget _menuItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.black),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Widget untuk Bottom Navigation Item
  Widget _bottomNavItem(String title, IconData icon, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 26, color: isActive ? Colors.green : Colors.black54),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.green : Colors.black54,
          ),
        ),
      ],
    );
  }
}
