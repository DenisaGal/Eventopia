import 'package:awp/core/models/lookup_model.dart';

class EventModel {
  final String? id;
  final String name;
  final String description;
  final int cost;
  final String location;
  final DateTime date;
  List<LookupModel>? categories;

  //String imageUrl;

  EventModel({
    this.id,
    required this.description,
    required this.name,
    required this.cost,
    required this.location,
    required this.date,
    this.categories,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        description: json['description'],
        name: json['name'],
        cost: json['cost'],
        location: json['location'],
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        categories: json['categories'] != null
            ? (json['categories'] as List)
                .map<LookupModel>((item) => LookupModel.fromJson(item))
                .toList()
            : []);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'name': name,
        'cost': cost,
        'location': location,
        'categories': categories?.map((c) => c.toJson()).toList(),
        'date': date.toIso8601String(),
      };
}
