import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/features/auth/domain/entities/app_user.dart';
import 'package:practicalibre_tade_xool/features/auth/presentation/components/my_text_field.dart';
import 'package:practicalibre_tade_xool/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:practicalibre_tade_xool/features/post/domain/entities/post.dart';
import 'package:practicalibre_tade_xool/features/post/presentation/cubits/post_cubit.dart';
import 'package:practicalibre_tade_xool/features/post/presentation/cubits/post_states.dart';
import 'package:practicalibre_tade_xool/responsive/constrained_scaffold.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UploadPostPage> {
  // mobile images pick
  PlatformFile? imagePickedFile;

  //web image pick
  Uint8List? webImage;

  //text controller -> caption
  final textController = TextEditingController();

  // current user
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // create & upload post
  void uploadPost() {
    // check if both image and caption are provided
    if (imagePickedFile == null || textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Both image and caption are required")));
      return;
    }

    //create a new post object
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: textController.text,
      imageUrl: '',
      timestamp: DateTime.now(),
      likes: [],
      comments: [],
    );

    //post cubit
    final postCubit = context.read<PostCubit>();

    //web upload
    if (kIsWeb) {
      postCubit.createPost(
        newPost,
      );
    }

    //mobile upload
    else {
      postCubit.createPost(newPost, imagePath: imagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //BLOC CONSUMER -> Builder + listener

    return BlocConsumer<PostCubit, PostStates>(
      builder: (context, state) {
        print(state);
        // loading ot uploading ..
        if (state is PostsUploading || state is PostsUploading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //build upload page
        return buildUploadPage();
      },
      //go to previous page when upload is done & posts are loaded
      listener: (context, state) {
        if (state is PostsLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildUploadPage() {
    //SCAFFOLD
    return ConstrainedScaffold(
      //  APP BAR
      appBar: AppBar(
          title: const Text("Create Post"),
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            //upload button
            IconButton(
              onPressed: uploadPost,
              icon: const Icon(Icons.upload),
            )
          ]),

      //BODY
      body: Center(
        child: Column(
          children: [
            //image preview for web
            if (kIsWeb && webImage != null) Image.memory(webImage!),

            //image preview for mobile
            if (kIsWeb && imagePickedFile != null)
              Image.file(File(imagePickedFile!.path!)),

            //pick image button
            MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: const Text("Pick Image"),
            ),

            //caption text box
            MyTextField(
              controller: textController,
              hintText: "Caption",
              obscureText: false,
            )
          ],
        ),
      ),
    );
  }
}
