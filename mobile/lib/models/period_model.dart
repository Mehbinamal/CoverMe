class PeriodModel {
  final int period;
  final String? classroom;
  final String? subject;

  const PeriodModel({required this.period, this.classroom, this.subject});

  bool get isFree => classroom == null;
}
