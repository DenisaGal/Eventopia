import 'package:awp/core/models/lookup_model.dart';

class UserDetailsModel {
  final String email;
  final bool isOrganizer;
  List<LookupModel> events;

  //String imageUrl;

  UserDetailsModel({
    required this.email,
    required this.isOrganizer,
    required this.events,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      email: json['email'],
      isOrganizer: json['isOrganizer'],
      events: json['events'] != null
          ? (json['events'] as List)
              .map<LookupModel>((item) => LookupModel.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'isOrganizer': isOrganizer,
        'events': events.map((event) => event.toJson()).toList(),
      };
}
