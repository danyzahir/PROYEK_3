import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../widgets/user_menu.dart';

class EditAgendaScreen extends StatefulWidget {
  final String username;

  const EditAgendaScreen({super.key, required this.username});

  @override
  State<EditAgendaScreen> createState() => _EditAgendaScreenState();
}

class _EditAgendaScreenState extends State<EditAgendaScreen> {
  final List<Map<String, String>> kegiatanList = [];
  DateTime? selectedDate;

  void _tambahAtauEditKegiatan({int? indexToEdit}) {
    String namaKegiatan =
        indexToEdit != null ? kegiatanList[indexToEdit]['nama']! : '';
    selectedDate = indexToEdit != null
        ? DateFormat('yyyy-MM-dd').parse(kegiatanList[indexToEdit]['tanggal']!)
        : DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title:
              Text(indexToEdit != null ? 'Edit Kegiatan' : 'Tambah Kegiatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: namaKegiatan,
                decoration: const InputDecoration(labelText: 'Nama Kegiatan'),
                onChanged: (value) => namaKegiatan = value,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    selectedDate != null
                        ? DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                            .format(selectedDate!)
                        : 'Pilih Tanggal',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        locale: const Locale('id', 'ID'),
                      );
                      if (picked != null) {
                        setStateDialog(() => selectedDate = picked);
                      }
                    },
                    child: const Text('Pilih'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (namaKegiatan.trim().isNotEmpty && selectedDate != null) {
                  final newKegiatan = {
                    'nama': namaKegiatan.trim(),
                    'tanggal': DateFormat('yyyy-MM-dd').format(selectedDate!),
                    'username': widget.username,
                    'timestamp': FieldValue.serverTimestamp(),
                  };

                  setState(() {
                    if (indexToEdit != null) {
                      kegiatanList[indexToEdit] = {
                        'nama': namaKegiatan.trim(),
                        'tanggal': DateFormat('yyyy-MM-dd')
                            .format(selectedDate!),
                      };
                    } else {
                      kegiatanList.add({
                        'nama': namaKegiatan.trim(),
                        'tanggal': DateFormat('yyyy-MM-dd')
                            .format(selectedDate!),
                      });
                    }
                  });

                  try {
                    await FirebaseFirestore.instance
                        .collection('agenda')
                        .add(newKegiatan);
                    Navigator.pop(context);
                  } catch (e) {
                    print("Gagal simpan ke Firestore: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menyimpan ke database')),
                    );
                  }
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _hapusKegiatan(int index) {
    setState(() {
      kegiatanList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
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
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.username,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            UserMenu(username: widget.username),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "EDIT AGENDA",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Tombol Tambah
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => _tambahAtauEditKegiatan(),
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text("Tambah",
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // List kegiatan
              ...kegiatanList.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading:
                          const Icon(Icons.event_note, color: Colors.white),
                      title: Text(item['nama'] ?? '',
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                          DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
                              DateFormat('yyyy-MM-dd')
                                  .parse(item['tanggal'] ?? '')),
                          style: const TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () =>
                                _tambahAtauEditKegiatan(indexToEdit: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => _hapusKegiatan(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
