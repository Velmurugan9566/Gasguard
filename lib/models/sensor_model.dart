class SensorData {
  final int value;

  SensorData({required this.value});

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(value: map['value'] ?? 0);
  }
}
