import 'package:flutter/material.dart';
import 'absensi.dart';
import 'home_screen.dart';
import 'nilai.dart';
import 'rekap_absensi.dart';
import '../widgets/user_menu.dart'; // opsional jika ingin pakai logout

class DataScreen extends StatelessWidget {
  final String username;

  const DataScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        Text(
                          username,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        UserMenu(username: username), // kalau mau pakai logout popup
                        // const CircleAvatar(...) bisa diganti ini
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "DATA GURU & ANAK",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Menu Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _menuItem("Data Guru SDIT", Icons.people),
                  _menuItem("Data Guru TKQ", Icons.people),
                  _menuItem("Data Murid SDIT", Icons.people),
                  _menuItem("Data Murid TKQ", Icons.people),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Bottom Navigation
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
                _navItem(context, "Dashboard", Icons.home, HomeScreen(username: username), false),
                _navItem(context, "Absensi", Icons.assignment_ind_rounded, AbsensiScreen(username: username), false),
                _navItem(context, "Nilai", Icons.my_library_books_rounded, NilaiScreen(username: username), false),
                _navItem(context, "Data Guru & Anak", Icons.person, DataScreen(username: username), true),
                _navItem(context, "Rekap Absensi", Icons.receipt_long, RekapScreen(username: username), false),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _navItem(BuildContext context, String title, IconData icon, Widget page, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: Column(
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
      ),
    );
  }
}
