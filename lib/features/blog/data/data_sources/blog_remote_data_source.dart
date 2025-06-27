import 'package:blog/features/blog/data/models/blogModel.dart';

abstract interface class BlogRemoteDataSource{

  Future<BlogMode> uploadBlog(BlogMode blog);

}

