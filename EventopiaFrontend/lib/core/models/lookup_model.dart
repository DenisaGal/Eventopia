class LookupModel {
  const LookupModel({
    required this.id,
    required this.details,
  });

  final String id;
  final String details;

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      id: json['id'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'details': details,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LookupModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
