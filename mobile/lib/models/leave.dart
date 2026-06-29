class Leave {
  final int? id;
  final int teacherId;
  final String date;
  final String reason;

  const Leave({
    this.id,
    required this.teacherId,
    required this.date,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "teacherId": teacherId,
      "date": date,
      "reason": reason,
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      id: map["id"],
      teacherId: map["teacherId"],
      date: map["date"],
      reason: map["reason"] ?? "",
    );
  }
}