class Blog {
  final String id;

  final String userId;
  final String title;
  final String content;
  late final List<String> topics;
  final String image_url;
  final DateTime atDateTime;

  Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image_url,
    required this.atDateTime,
  });
}
