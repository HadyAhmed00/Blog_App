import 'package:blog/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog/features/blog/domain/entite/blog.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:meta/meta.dart';
import 'dart:io';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final res = await _uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        userId: event.userId,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(l.massage)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final res = await _getAllBlogs(Noparams());

    res.fold(
      (l) => emit(BlogFailure(l.massage)),
      (r) => emit(BlogsDisplaySuccess(r)),
    );
  }
}
