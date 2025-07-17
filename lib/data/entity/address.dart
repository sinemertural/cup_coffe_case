class Address {
  final String id;
  final String title;
  final String details;
  bool isSelected;

  Address({
    required this.id,
    required this.title,
    required this.details,
    this.isSelected = false
  });
}
