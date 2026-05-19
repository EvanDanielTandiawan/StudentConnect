import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String selectedProgram = "Informatics Engineering";

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString("name") ?? "";
      bioController.text = prefs.getString("bio") ?? "";
      selectedProgram = prefs.getString("program") ?? "Informatics Engineering";
    });
  }

  Future<void> saveChanges(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", nameController.text);
    await prefs.setString("bio", bioController.text);
    await prefs.setString("program", selectedProgram);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Sukses"),
        content: Text("Data berhasil diperbarui!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: "Biografi"),
            ),
            DropdownButton<String>(
              value: selectedProgram,
              items: [
                "Informatics Engineering",
                "Computer Science",
                "Information Systems",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) {
                setState(() {
                  selectedProgram = val!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => saveChanges(context),
              child: Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}
