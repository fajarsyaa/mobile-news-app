class SourceModel {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  SourceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      category: json['category'].toString(),
      language: json['language'].toString(),
      country: json['country'].toString(),
    );
  }
}

