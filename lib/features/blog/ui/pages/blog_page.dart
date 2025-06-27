import 'package:blog/core/common/widget/loader.dart';
import 'package:blog/core/utiles/show_snackbar.dart';
import 'package:blog/features/blog/ui/bloc/blog_bloc.dart';
import 'package:blog/features/blog/ui/pages/add_blog_page.dart';
import 'package:blog/features/blog/ui/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddBlogPage.route);
            },
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? const Color.fromARGB(255, 4, 46, 56)
                      : const Color.fromARGB(255, 56, 4, 4),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
