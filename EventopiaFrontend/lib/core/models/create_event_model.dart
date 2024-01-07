class CreateEventModel {
  final String? id;
  final String name;
  final String description;
  final int cost;
  final String location;
  final DateTime date;
  List<String>? categories;

  //String imageUrl;

  CreateEventModel({
    this.id,
    required this.description,
    required this.name,
    required this.cost,
    required this.location,
    required this.date,
    this.categories,
  });

  factory CreateEventModel.fromJson(Map<String, dynamic> json) {
    return CreateEventModel(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      cost: json['cost'],
      location: json['location'],
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      categories:
          (json['categories'] as List).map((r) => r.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'name': name,
        'cost': cost,
        'location': location,
        'categories': categories,
        'date': date.toIso8601String(),
      };
}
