import 'package:blog/core/error/failurs.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entite/blog.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, Noparams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(Noparams params) async {
    return await blogRepository.getAllBlogs();
  }
}
