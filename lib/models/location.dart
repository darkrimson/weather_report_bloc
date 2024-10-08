class Location {
  final String name;

  Location({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
    );
  }
}
