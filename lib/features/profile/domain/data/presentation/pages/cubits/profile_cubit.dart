import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/cubits/profile_states.dart';
import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/entities/profile_user.dart';
import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/repos/profile_repo.dart';
import 'package:practicalibre_tade_xool/features/storage/domain/storage_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;

  ProfileCubit({required this.profileRepo, required this.storageRepo})
      : super(ProfileInitial());

  //fetch user profile using repo -> useful for loading single profile pages
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

//return user profile given uid -> useful for loading many profile foe posts
  Future<ProfileUser?> getUserProfile(String uid) async {
    final user = await profileRepo.fetchUserProfile(uid);
    return user;
  }

  //update bio and or profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
    Uint8List? imageWebBytes,
    String? imageMobilePath,
  }) async {
    emit(ProfileLoading());

    try {
      // fetch current profile first
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Failed to fecth user for profile update"));
        return;
      }

      //profile picture update
      String? imageDownloadUrl;
      // ensure there is a an image
      if (imageWebBytes != null || imageMobilePath != null) {
        // for mobile
        if (imageMobilePath != null) {
          //upload
          imageDownloadUrl =
              await storageRepo.uploadProfileImageMobile(imageMobilePath, uid);
        }
        //for web
        else if (imageWebBytes != null) {
          //upload
          imageDownloadUrl =
              await storageRepo.uploadProfileImageWeb(imageWebBytes, uid);
        }

        if (imageDownloadUrl == null) {
          emit(ProfileError("Failed to upload image"));
          return;
        }
      }

      //update new profile
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
        newProfileImageUrl: imageDownloadUrl ?? currentUser.profileImageUrl,
      );

      //update in repo
      await profileRepo.updateProfile(updatedProfile);

      //re-fecth the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }

// toogle follow/unfollow
  Future<void> toggleFollow(String currentUserId, String targetUserId) async {
    try {
      await profileRepo.toggleFollow(currentUserId, targetUserId);
    } catch (e) {
      emit(ProfileError("Error toggling follow:$e"));
    }
  }
}
