class Checklist {
  final int id;
  final String name;

  Checklist({required this.id, required this.name});

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      name: json['name'],
    );
  }
}
