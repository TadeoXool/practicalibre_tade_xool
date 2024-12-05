import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/features/post/domain/entities/comment.dart';
import 'package:practicalibre_tade_xool/features/post/domain/entities/post.dart';
import 'package:practicalibre_tade_xool/features/post/domain/repos/post_repo.dart';
import 'package:practicalibre_tade_xool/features/storage/domain/storage_repo.dart';

import 'post_states.dart';

class PostCubit extends Cubit<PostStates> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({required this.postRepo, required this.storageRepo})
      : super(PostsInitial());

  // create a new post

  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      // handle image upload for mobile platforms (using file path)
      if (imagePath != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageMobile(imagePath, post.id);
      }

      // handle image upload for web platforms (using file bytes)
      else if (imageBytes != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageWeb(imageBytes, post.id);
      }

      //give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      //create post in thr backend
      postRepo.createPost(newPost);

      //re-fetch all posts
      fetchAllPosts();
    } catch (e) {
      emit(PostsError("Failed to create post: $e"));
    }
  }

  //fetch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostLoading());
      final posts = await postRepo.fecthAllPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError("Failed to fetch posts: $e"));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {}
  }

  // toggle like on a post
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      await postRepo.toggleLikePost(postId, userId);
    } catch (e) {
      emit(PostsError("Failed to toggle like: $e"));
    }
  }

  //add a cooment to a post
  Future<void> addComment(String postId, Comment comment) async {
    try {
      await postRepo.addComment(postId, comment);
    } catch (e) {
      emit(PostsError("Failed to add comment: $e"));
    }
  }

  //delete comment from a post
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await postRepo.deleteComment(postId, commentId);

      await fetchAllPosts();
    } catch (e) {
      emit(PostsError("Failed to delete comment: $e"));
    }
  }
}
