import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header hijau
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Logo dan User Avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/icon.png',
                      height: 50, // Sesuaikan tinggi
                    ),
                    Row(
                      children: [
                        const Text(
                          "User",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 18,
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Judul DASHBOARD
                const Text(
                  "DASHBOARD",
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

          // Pengumuman (Contoh: Pembagian Rapot)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.black54, size: 16),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Rabu, 13 Oktober 2023",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        "Pembagian Rapot",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Grid Menu
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              crossAxisCount: 2, // Dua kolom
              crossAxisSpacing: 12, // Jarak antar kolom lebih kecil
              mainAxisSpacing: 12, // Jarak antar baris lebih kecil
              childAspectRatio: 1.2, // Supaya bentuknya tidak terlalu besar
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/absensi'); // Pindah ke halaman Absensi
                  },
                  child: _menuItem("Absensi", Icons.people_alt),
                ),
                _menuItem("Nilai", Icons.school),
                _menuItem("Data Siswa & Guru", Icons.person),
                _menuItem("Rekap Absensi", Icons.receipt_long),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Footer
          const Text(
            "© 2024 Powered by Nahdlatut Tujjar",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget untuk menu item
  Widget _menuItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Lebih kecil biar mirip di gambar
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
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
          Icon(icon, size: 35, color: Colors.black), // Icon lebih kecil
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
}
