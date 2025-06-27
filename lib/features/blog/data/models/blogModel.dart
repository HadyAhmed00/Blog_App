import 'package:blog/features/blog/domain/entite/blog.dart';
import 'package:hive/hive.dart';

part 'blogModel.g.dart';

@HiveType(typeId: 0)
class BlogMode extends Blog {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final List<String> topics;
  @HiveField(5)
  final String image_url;
  @HiveField(6)
  final DateTime atDateTime;

  BlogMode({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image_url,
    required this.atDateTime,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          content: content,
          topics: topics,
          image_url: image_url,
          atDateTime: atDateTime,
        );

  factory BlogMode.fromJson(Map<String, dynamic> map) {
    return BlogMode(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      topics: List<String>.from(map['topics'] ?? []),
      image_url: map['image_url'],
      atDateTime: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'topics': topics,
      'image_url': image_url,
      'updated_at': atDateTime.toIso8601String(),
    };
  }

  BlogMode copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    List<String>? topics,
    String? image_url,
    DateTime? atDateTime,
  }) {
    return BlogMode(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      image_url: image_url ?? this.image_url,
      atDateTime: atDateTime ?? this.atDateTime,
    );
  }
}
