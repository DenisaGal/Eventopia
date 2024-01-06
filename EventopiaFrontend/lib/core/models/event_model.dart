 class EventModel {
  final String? id;
  final String name;
  final String description;
  final int cost;
  final String location;
  final DateTime date;

  //String imageUrl;

  const EventModel({
    this.id,
    required this.description,
    required this.name,
    required this.cost,
    required this.location,
    required this.date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      cost: json['cost'],
      location: json['location'],
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'name': name,
        'cost': cost,
        'location': location,
        'date': date.toIso8601String(),
      };
}
