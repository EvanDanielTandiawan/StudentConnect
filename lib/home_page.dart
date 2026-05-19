import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_page.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';
import 'models/student.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name, nrp;
  List<Student> students = [];

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "Unknown";
      nrp = prefs.getString("nrp") ?? "-";
    });
  }

  void loadDummyStudents() {
    students = [
      Student(
        nrp: "5025211001",
        name: "Ahmad Rizki Pratama",
        program: "Informatics Engineering",
        bio: "Suka ngoding Flutter",
      ),
      Student(
        nrp: "5025211002",
        name: "Sari Indah Permata",
        program: "Information Systems",
        bio: "Penggemar UI/UX Design",
      ),
      Student(
        nrp: "5025211003",
        name: "Dimas Kurniawan",
        program: "Computer Science",
        bio: "Belajar AI",
      ),
      Student(
        nrp: "5025211004",
        name: "Nadia Putri",
        program: "Information Technology",
        bio: "Hobi fotografi dan desain grafis",
      ),
    ];
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    loadDummyStudents(); // panggil data dummy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Daftar Mahasiswa"),
        backgroundColor: Colors.blue[900],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name ?? "Guest"),
              accountEmail: Text(nrp ?? "-"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("/profile.png"),
              ),
              decoration: BoxDecoration(color: Colors.blue[900]),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditProfilePage()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("/profile.png"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "NRP: ${s.nrp}",
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailPage(student: s), // 🧩 kirim data Student
                        ),
                      );
                    },
                    child: const Text(
                      "Lihat Detail Profil",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
