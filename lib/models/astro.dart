class Astro {
  final String sunrise;
  final String sunset;

  Astro({required this.sunrise, required this.sunset});

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
