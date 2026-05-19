import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nrpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("nrp", nrpController.text);
    await prefs.setString("name", nameController.text);
    await prefs.setString("program", "Informatics Engineering");
    await prefs.setString("bio", "Mahasiswa UBAYA");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nrpController,
              decoration: InputDecoration(labelText: "NRP"),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
