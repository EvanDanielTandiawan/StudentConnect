import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';
import 'dart:convert';

class SharedPrefsService {
  static const String keyIsLoggedIn = "isLoggedIn";
  static const String keyStudent = "student";

  // Simpan status login
  static Future<void> setLogin(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, status);
  }

  // Ambil status login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  // Simpan data Student (diubah ke JSON string)
  static Future<void> saveStudent(Student student) async {
    final prefs = await SharedPreferences.getInstance();
    String studentJson = jsonEncode(student.toMap());
    await prefs.setString(keyStudent, studentJson);
  }

  // Ambil data Student (dari JSON string → object Student)
  static Future<Student?> getStudent() async {
    final prefs = await SharedPreferences.getInstance();
    String? studentJson = prefs.getString(keyStudent);
    if (studentJson == null) return null;
    return Student.fromMap(jsonDecode(studentJson));
  }

  // Logout (hapus semua data)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
