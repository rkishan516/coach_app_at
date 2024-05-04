import 'package:appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/common/model/shikhsha_dhra_user.dart';
import 'package:shiksha_dhra/app/common/services/appwrite_db_service.dart';

part 'current_user_state_notifier.g.dart';

enum Role {
  student,
  teacher,
  headOfDepartment,
  headOfInstitute,
}

@Riverpod(keepAlive: true)
class CurrentUserStateNotifier extends _$CurrentUserStateNotifier {
  @override
  User? build() {
    return null;
  }

  Future<User?> load() async {
    state = await ref.read(appwriteAuthServiceProvider).getCurrentUser();
    return state;
  }
}

@Riverpod(keepAlive: true)
class SikhshaDhraUserNotifier extends _$SikhshaDhraUserNotifier {
  @override
  ShikshaDhraUser? build() {
    return null;
  }

  Future<ShikshaDhraUser?> load() async {
    final currentUser = ref.read(currentUserStateNotifierProvider);
    if (currentUser == null) {
      state = null;
      return state;
    }
    state = await ref.read(appwriteDbServiceProvider).getUser(currentUser.$id);
    return state;
  }
}
