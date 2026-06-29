class Teacher {
  final int? id;
  final String name;
  final String department;

  const Teacher({
    this.id,
    required this.name,
    this.department = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "department": department,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map["id"],
      name: map["name"],
      department: map["department"] ?? "",
    );
  }

  Teacher copyWith({
    int? id,
    String? name,
    String? department,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
    );
  }
}