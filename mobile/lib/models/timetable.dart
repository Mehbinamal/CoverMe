class Timetable {
  final int? id;

  final int teacherId;

  final int day;

  final int period;

  final String classroom;

  final String subject;

  const Timetable({
    this.id,
    required this.teacherId,
    required this.day,
    required this.period,
    required this.classroom,
    required this.subject,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "teacherId": teacherId,
      "day": day,
      "period": period,
      "classroom": classroom,
      "subject": subject,
    };
  }

  factory Timetable.fromMap(
      Map<String, dynamic> map) {
    return Timetable(
      id: map["id"],
      teacherId: map["teacherId"],
      day: map["day"],
      period: map["period"],
      classroom: map["classroom"],
      subject: map["subject"],
    );
  }
}