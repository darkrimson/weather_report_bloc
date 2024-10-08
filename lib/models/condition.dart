class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
    };
  }

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}
