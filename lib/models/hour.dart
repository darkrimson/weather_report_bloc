class Hour {
  final String time;
  final double tempC;
  final String conditionText;

  Hour({
    required this.time,
    required this.tempC,
    required this.conditionText,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    String formattedTime = json['time'].split(' ')[1];
    return Hour(
      time: formattedTime,
      tempC: json['temp_c'],
      conditionText: json['condition']['text'],
    );
  }
}
