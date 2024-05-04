import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/common/model/course.dart';
import 'package:shiksha_dhra/app/common/notifiers/current_user_state_notifier.dart';
import 'package:shiksha_dhra/app/common/services/appwrite_db_service.dart';
import 'package:shiksha_dhra/app/home/state/page_state.dart';

part 'page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  @override
  HomePageState build() {
    loadUserData();
    return const HomePageState.loading();
  }

  Future<void> loadUserData() async {
    final user =
        ref.read(sikhshaDhraUserNotifierProvider.select((value) => value!));
    final role = user.role;
    final currUser = ref.read(currentUserStateNotifierProvider)!;
    if (role == Role.student) {
      final userCourses =
          await ref.read(appwriteDbServiceProvider).getUserCourse(currUser.$id);
      final courses = await Future.wait(userCourses.map((e) async {
        return await ref.read(appwriteDbServiceProvider).getCourse(e.courseId);
      }));
      state = HomePageState.student(course: courses);
    } else if (role == Role.teacher) {
      final courses = await ref
          .read(appwriteDbServiceProvider)
          .getInstituteCourses(user.instituteId!);
      state = HomePageState.teacher(course: courses);
    } else if (role == Role.headOfDepartment) {
      final courses = await ref
          .read(appwriteDbServiceProvider)
          .getInstituteCourses(user.instituteId!);
      state = HomePageState.headOfDepartment(course: courses);
    } else {
      state = const HomePageState.headOfInstitute();
    }
  }

  void addCourse(Course course) async {
    await ref.read(appwriteDbServiceProvider).createCourse(course);
    state = state.when(
      loading: () => state,
      student: (courses) => state,
      teacher: (courses) => state,
      headOfDepartment: (courses) =>
          HomePageState.headOfDepartment(course: [...courses, course]),
      headOfInstitute: () => const HomePageState.headOfInstitute(),
    );
  }

  void logout() async {
    await ref.read(appwriteAuthServiceProvider).logout();
  }
}
