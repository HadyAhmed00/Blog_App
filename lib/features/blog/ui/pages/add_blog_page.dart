import 'package:blog/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/blog_edetor.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  static final String route = "/addNote";

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final TextEditingController _titleContrloler = TextEditingController();
  final TextEditingController _contantContrloler = TextEditingController();

  final List<String> selectedTopic = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.done_outline_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: AppPallete.borderColor,
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  radius: Radius.circular(20),
                ),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_copy_outlined, size: 40),
                      SizedBox(height: 10),
                      Text("Chose File"),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      [
                            "Technology",
                            "Beefiness",
                            "Programming",
                            "Entertainment",
                          ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopic.contains(e)) {
                                    selectedTopic.remove(e);
                                  } else {
                                    selectedTopic.add(e);
                                  }
                                  if (kDebugMode) {
                                    print(selectedTopic);
                                  }
                                  setState(() {

                                  });
                                },
                                child: Chip(
                                  label: Text(e),
                                  side: BorderSide(
                                    color: AppPallete.borderColor,
                                  ),
                                  backgroundColor: AppPallete.backgroundColor,
                                  color: selectedTopic.contains(e)
                                      ? WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              BlogEditor(
                controller: _titleContrloler,
                lable: "Title",
                hint: "Enter The Title",
              ),
              SizedBox(height: 25),
              BlogEditor(
                controller: _contantContrloler,
                lable: "Content",
                hint: "Enter The content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
