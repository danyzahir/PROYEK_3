import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class AkunGuruScreen extends StatefulWidget {
  final String username;

  const AkunGuruScreen({super.key, required this.username});

  @override
  State<AkunGuruScreen> createState() => _AkunGuruScreenState();
}

class _AkunGuruScreenState extends State<AkunGuruScreen> {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');

  void _showTambahDialog() {
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Akun Guru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Username')),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCred = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());

                  await _users.doc(userCred.user!.uid).set({
                    'email': emailController.text.trim(),
                    'username': usernameController.text.trim(),
                    'role': 'user',
                    'deleted': false,
                  });

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Gagal: $e')));
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String docId, String currentEmail, String currentUsername) {
    final emailController = TextEditingController(text: currentEmail);
    final usernameController = TextEditingController(text: currentUsername);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Akun Guru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Username')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              onPressed: () async {
                await _users.doc(docId).update({
                  'email': emailController.text.trim(),
                  'username': usernameController.text.trim(),
                });
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _confirmHapus(String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Akun?"),
        content: const Text("Data akun ini akan disembunyikan dan bisa dipulihkan nanti."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () async {
              await _users.doc(docId).update({'deleted': true});
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  void _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Link reset dikirim ke email")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal kirim reset: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Back
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // Title
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "AKUN GURU",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                // Logout
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.username, style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'logout') {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red),
                                SizedBox(width: 10),
                                Text('Logout'),
                              ],
                            ),
                          ),
                        ],
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 18,
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _showTambahDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),

          // List Akun
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _users.where('role', isEqualTo: 'user').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return (data['deleted'] ?? false) == false;
                }).toList();

                if (docs.isEmpty) {
                  return const Center(child: Text("Tidak ada akun guru"));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        title: Text(data['username'] ?? ''),
                        subtitle: Text(data['email'] ?? ''),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditDialog(doc.id, data['email'], data['username']);
                            } else if (value == 'hapus') {
                              _confirmHapus(doc.id);
                            } else if (value == 'reset') {
                              _resetPassword(data['email']);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text("Edit")),
                            const PopupMenuItem(value: 'reset', child: Text("Reset Password")),
                            const PopupMenuItem(value: 'hapus', child: Text("Hapus")),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text('© 2025 Powered by Nahdlatut Tujjar'),
          ),
        ],
      ),
    );
  }
}
