import 'package:blog/core/common/cubits/user_login/user_login_cubit.dart';
import 'package:blog/core/common/widget/loader.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utiles/show_snackbar.dart';
import 'package:blog/features/blog/ui/bloc/blog_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:blog/core/utils/image_picker_service.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  File? image;

  final ImagePickerService _imagePickerService = ImagePickerService();

  void selectImage() async {
    final pickedImage = await _imagePickerService.pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (image != null &&
        _titleContrloler.text.isNotEmpty &&
        _contantContrloler.text.isNotEmpty &&
        selectedTopic.isNotEmpty) {
      final userId = (context.read<UserLoginCubit>().state as UserIsLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
              userId: userId,
              title: _titleContrloler.text.trim(),
              content: _contantContrloler.text.trim(),
              image: image!,
              topics: selectedTopic,
            ),
          );
    } else {
      showSnackBar(context, 'Please fill all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        actions: [
          IconButton(
              onPressed: uploadBlog, icon: Icon(Icons.done_outline_rounded)),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
          if (state is BlogUploadSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  image != null
                      ? GestureDetector(
                          onTap: selectImage,
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppPallete.borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  'Select your image',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        "Technology",
                        "Business",
                        "Programming",
                        "Entertainment",
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopic.contains(e)) {
                                    selectedTopic.remove(e);
                                  } else {
                                    selectedTopic.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopic.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPallete.gradient1)
                                      : null,
                                  side: selectedTopic.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlogEditor(
                    controller: _titleContrloler,
                    hint: "Blog title",
                    lable: "Title",
                  ),
                  const SizedBox(height: 10),
                  BlogEditor(
                    controller: _contantContrloler,
                    hint: "Blog content",
                    lable: "Content",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
