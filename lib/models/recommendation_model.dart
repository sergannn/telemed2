class RecommendationModel {
  final int id;
  final String title;
  final String? description;
  final String image;
  final String? html;
  final int? category_id;
  final int? duration;
  final String? created_at;
  final String? updated_at;

  RecommendationModel({
    required this.id,
    required this.title,
    this.description,
    required this.image,
    this.html,
    this.category_id,
    this.duration,
    this.created_at,
    this.updated_at,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      html: json['html'] as String?,
      category_id: json['category_id'] as int?,
      duration: json['duration'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'html': html,
      'category_id': category_id,
      'duration': duration,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
