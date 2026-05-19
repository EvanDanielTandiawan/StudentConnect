import 'package:flutter/material.dart';
import 'models/student.dart';

class DetailPage extends StatelessWidget {
  final Student student; //  data mahasiswa dikirim dari HomePage

  const DetailPage({Key? key, required this.student}) : super(key: key);

  void addFriend(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil!"),
        content: Text("Kamu telah menambahkan ${student.name} sebagai teman."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("/profile.png"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("NRP: ${student.nrp}"),
                  const SizedBox(height: 8),
                  Text("Program: ${student.program}"),
                  const SizedBox(height: 8),
                  Text(
                    student.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addFriend(context),
        icon: const Icon(Icons.person_add),
        label: const Text("Tambah Teman"),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
