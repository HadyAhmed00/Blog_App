import 'package:blog/features/blog/domain/entite/blog.dart';

class BlogMode extends Blog {
  BlogMode({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.topics,
    required super.image_url,
    required super.atDateTime,
  });
}
