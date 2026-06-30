class Task {
  final int? id;

  final int teacherId;

  final int? assignedTeacherId;

  final int day;

  final String date;

  final int period;

  final String classroom;

  final String subject;

  final String status;

  const Task({
    this.id,
    required this.teacherId,
    this.assignedTeacherId,
    required this.day,
    required this.date,
    required this.period,
    required this.classroom,
    required this.subject,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "teacherId": teacherId,
      "assignedTeacherId": assignedTeacherId,
      "day": day,
      "date": date,
      "period": period,
      "classroom": classroom,
      "subject": subject,
      "status": status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      teacherId: map["teacherId"],
      assignedTeacherId: map["assignedTeacherId"],
      day: map["day"],
      date: map["date"],
      period: map["period"],
      classroom: map["classroom"],
      subject: map["subject"],
      status: map["status"],
    );
  }
}
