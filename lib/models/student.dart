class Student {
  final String nrp;
  final String name;
  final String program;
  final String bio;

  Student({
    required this.nrp,
    required this.name,
    required this.program,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    return {'nrp': nrp, 'name': name, 'program': program, 'bio': bio};
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      nrp: map['nrp'] ?? '',
      name: map['name'] ?? '',
      program: map['program'] ?? '',
      bio: map['bio'] ?? '',
    );
  }
}

// ✅ List mahasiswa ditempatkan di luar class
final List<Student> students = [
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
];
