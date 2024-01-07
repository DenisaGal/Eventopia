import 'package:awp/core/models/lookup_model.dart';

class PreferenceModel {
  PreferenceModel({
    required this.categoryName,
    required this.rating,
    required this.events,
  });

  final String categoryName;
  final double rating;
  List<LookupModel> events;

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
      categoryName: json['categoryName'],
      rating: json['rating'],
      events: json['events'] != null
          ? (json['events'] as List)
              .map<LookupModel>((item) => LookupModel.fromJson(item))
              .toList()
          : [],
    );
  }
}
