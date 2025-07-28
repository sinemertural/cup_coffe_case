class Address {
  String id;
  final String title;
  final String details;

  Address({
    required this.id,
    required this.title,
    required this.details,
  });

  factory Address.fromJson(Map<String, dynamic> json, String key) {
    return Address(
        id: key,
        title: json["title"] as String? ?? "",
        details: json["details"] as String? ?? "");
  }
}
