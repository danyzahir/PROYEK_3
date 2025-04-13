import 'package:flutter/material.dart';
import 'absensi.dart';
import 'home_screen.dart';
import 'nilai.dart';
import 'rekap_absensi.dart';
import '../widgets/user_menu.dart';

class DataScreen extends StatelessWidget {
  final String username;

  const DataScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header Hijau
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.04),
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
                          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        UserMenu(username: username),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  "DATA GURU & ANAK",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Pengumuman Kalender
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.black54, size: screenWidth * 0.04),
                  SizedBox(width: screenWidth * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Senin, 15 April 2024",
                        style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black54),
                      ),
                      Text(
                        "Penerimaan Siswa Baru",
                        style: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.025),

          // Menu Grid (Wrap supaya responsive)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Wrap(
                spacing: screenWidth * 0.04,
                runSpacing: screenHeight * 0.02,
                alignment: WrapAlignment.center,
                children: [
                  _menuItem("Data Guru SDIT", Icons.people, screenWidth, screenHeight),
                  _menuItem("Data Guru TKQ", Icons.people, screenWidth, screenHeight),
                  _menuItem("Data Murid SDIT", Icons.people, screenWidth, screenHeight),
                  _menuItem("Data Murid TKQ", Icons.people, screenWidth, screenHeight),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Bottom Navigation
          Container(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
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
                _navItem(context, "Dashboard", Icons.home, HomeScreen(username: username), false, screenWidth),
                _navItem(context, "Absensi", Icons.assignment_ind_rounded, AbsensiScreen(username: username), false, screenWidth),
                _navItem(context, "Nilai", Icons.my_library_books_rounded, NilaiScreen(username: username), false, screenWidth),
                _navItem(context, "Data Guru & Anak", Icons.person, DataScreen(username: username), true, screenWidth),
                _navItem(context, "Rekap Absensi", Icons.receipt_long, RekapScreen(username: username), false, screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title, IconData icon, double screenWidth, double screenHeight) {
    return SizedBox(
      width: (screenWidth - (screenWidth * 0.05 * 2 + screenWidth * 0.04)) / 2,
      height: screenHeight * 0.14,
      child: Container(
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
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
    bool isActive,
    double screenWidth,
  ) {
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
          Icon(icon, size: screenWidth * 0.06, color: isActive ? Colors.green : Colors.black54),
          SizedBox(height: screenWidth * 0.01),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.025,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.green : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
