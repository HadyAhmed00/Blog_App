import 'package:blog/features/blog/ui/pages/add_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

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
      body: Text("home page"),
    );
  }
}
