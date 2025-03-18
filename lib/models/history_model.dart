class HistoryData {
  final int sno;
  final int value;
  final String date;
  final String time;
  final String month;

  HistoryData({
    required this.sno,
    required this.value,
    required this.date,
    required this.time,
    required this.month,
  });

  factory HistoryData.fromMap(Map<String, dynamic> map) {
    return HistoryData(
      sno: map['sno'] ?? 0,
      value: map['value'] ?? 0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      month: map['month'] ?? '',
    );
  }
}
