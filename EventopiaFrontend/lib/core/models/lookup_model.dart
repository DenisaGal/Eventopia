class LookupModel {
  const LookupModel({
    required this.id,
    required this.details,
    this.extra,
  });

  final String id;
  final String details;
  final String? extra;

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      id: json['id'],
      details: json['details'],
      extra: json['extra'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'details': details,
        'extra': extra,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LookupModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
