import 'package:flutter/material.dart';
import 'absensi_guru.dart';

class AbsensiScreen extends StatelessWidget {
  const AbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Warna background
      body: Column(
        children: [
          // Header Hijau
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Back di Kiri
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                // Judul di Tengah
                const Expanded(
                  child: Center(
                    child: Text(
                      "ABSENSI",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // User Avatar dan Ikon di Kanan
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "User",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
          ),

          const SizedBox(height: 20),

          // Grid Menu (Posisi Sesuai Gambar)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Pusatkan item di layar
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AbsensiGuruPage()),
                        );
                      },
                      child: _menuItem("Absensi Guru", Icons.people_alt),
                    ),
                    const SizedBox(width: 20), // Spasi antar kotak
                    _menuItem("Absensi SDIT", Icons.school),
                  ],
                ),
                const SizedBox(height: 20), // Jarak ke item ketiga
                _menuItem("Absensi TKQ", Icons.group), // Item ketiga di tengah
              ],
            ),
          ),

          const SizedBox(height: 20),

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
                _bottomNavItem("Dashboard", Icons.home, true),
                _bottomNavItem("Absensi", Icons.check_circle, false),
                _bottomNavItem("Nilai", Icons.assignment, false),
                _bottomNavItem("Data Siswa & Guru", Icons.person, false),
                _bottomNavItem("Rekap Absensi", Icons.receipt_long, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Menu Item
  Widget _menuItem(String title, IconData icon) {
    return Container(
      width: 200, // Ukuran box diperbesar
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Lebih rounded untuk tampilan modern
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.black), // Ukuran icon lebih besar
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
