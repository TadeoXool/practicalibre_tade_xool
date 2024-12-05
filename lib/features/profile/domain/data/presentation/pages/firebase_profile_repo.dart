import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practicalibre_tade_xool/features/post/data/firebase_post_repo.dart';
import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/entities/profile_user.dart';
import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      //get user document from firestore
      final userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          // fetch followers & following
          final followers = List<String>.from(userData['followers'] ?? []);
          final following = List<String>.from(userData['following'] ?? []);
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString(),
            followers: followers,
            following: following,
          );
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    try {
      //convert update profile to jason to store in firestore
      await firebaseFirestore
          .collection('users')
          .doc(updateProfile.uid)
          .update({
        'bio': updateProfile.bio,
        'profileImageUrl': updateProfile.profileImageUrl
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> toggleFollow(String currentUid, String targetUid) async {
    try {
      final currentUserDoc =
          await firebaseFirestore.collection('users').doc(currentUid).get();
      final targetUserDoc =
          await firebaseFirestore.collection('users').doc(currentUid).get();

      if (currentUserDoc.exists && targetUserDoc.exists) {
        final currentUserData = currentUserDoc.data();
        final targetUserData = targetUserDoc.data();

        if (currentUserData != null && targetUserData != null) {
          final List<String> currentFollowing =
              List<String>.from(currentUserData['following'] ?? []);

          //chechk if the currrent user is already following the target user
          if (currentFollowing.contains(targetUid)) {
            //unfollow
            await firebaseFirestore.collection('users').doc(currentUid).update({
              'following': FieldValue.arrayRemove([targetUid])
            });

            await firebaseFirestore.collection('users').doc(targetUid).update({
              'followers': FieldValue.arrayRemove([currentUid])
            });
          } else {
            //follow
            await firebaseFirestore.collection('users').doc(currentUid).update({
              'following': FieldValue.arrayUnion([targetUid])
            });

            await firebaseFirestore.collection('users').doc(targetUid).update({
              'followers': FieldValue.arrayUnion([currentUid])
            });
          }
        }
      }
    } catch (e) {}
  }
}