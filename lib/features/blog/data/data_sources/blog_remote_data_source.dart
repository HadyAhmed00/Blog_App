import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/blog/data/models/blogModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogMode> uploadBlog(BlogMode blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogMode blog,
  });
  Future<List<BlogMode>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogMode> uploadBlog(BlogMode blog) async {
    try {
      final blogData = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogMode.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogMode blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogMode>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient.from('blogs').select('*, profiles (name)');
      return blogs.map((e) => BlogMode.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

