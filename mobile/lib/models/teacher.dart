class Teacher {
  final int? id;
  final String name;
  final String homeroom;

  const Teacher({this.id, required this.name, this.homeroom = ""});

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "homeroom": homeroom};
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map["id"],
      name: map["name"],
      homeroom: map["homeroom"] ?? "",
    );
  }

  Teacher copyWith({int? id, String? name, String? homeroom}) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      homeroom: homeroom ?? this.homeroom,
    );
  }
}
