import 'package:practicalibre_tade_xool/features/profile/domain/data/presentation/pages/entities/profile_user.dart';

abstract class SearchRepo {
  Future<List<ProfileUser>> searchUsers(String query);
}
