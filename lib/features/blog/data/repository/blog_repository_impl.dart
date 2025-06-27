import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failurs.dart';
import 'package:blog/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blogModel.dart';
import 'package:blog/features/blog/domain/entite/blog.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      BlogMode blogModel = BlogMode(
        id: Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        topics: topics,
        image_url: '',
        atDateTime: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(
        image_url: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.massage));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.cacheBlogs(blogs);
      return right(blogs);
    } on ServerException catch (e) {
      final blogs = blogLocalDataSource.getCachedBlogs();
      if (blogs.isNotEmpty) {
        return right(blogs);
      }
      return left(Failure(e.massage));
    }
  }
}
