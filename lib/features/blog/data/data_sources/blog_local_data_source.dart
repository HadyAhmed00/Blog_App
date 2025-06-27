import 'package:hive/hive.dart';
import 'package:blog/features/blog/data/models/blogModel.dart';

abstract interface class BlogLocalDataSource {
  void cacheBlogs(List<BlogMode> blogs);
  List<BlogMode> getCachedBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box<BlogMode> blogBox;

  BlogLocalDataSourceImpl(this.blogBox);

  @override
  void cacheBlogs(List<BlogMode> blogs) {
    blogBox.clear();
    for (final blog in blogs) {
      blogBox.put(blog.id, blog);
    }
  }

  @override
  List<BlogMode> getCachedBlogs() {
    return blogBox.values.toList();
  }
}
