import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AbsensiGuruPage()),
            );
          },
          child: Text('Go to Absensi Guru'),
        ),
      ),
    );
  }
}

class AbsensiGuruPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          'ABSENSI GURU',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text('User', style: TextStyle(color: Colors.white)),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.green),
              ),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.camera_alt, size: 40),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Nilai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Data Siswa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Rekap',
          ),
        ],
      ),
    );
  }
}
