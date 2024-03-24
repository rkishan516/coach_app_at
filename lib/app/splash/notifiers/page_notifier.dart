import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/routes/notifiers/app_router.dart';
import 'package:shiksha_dhra/app/routes/notifiers/app_routes.dart';
import 'package:supercharged/supercharged.dart';

part 'page_notifier.g.dart';

@riverpod
class SplashPageNotifier extends _$SplashPageNotifier {
  @override
  void build() {
    return;
  }

  Future<void> runStartUpLogic() async {
    await 3.seconds.delay;
    final user = await ref.read(appwriteAuthServiceProvider).getCurrentUser();
    if (user == null) {
      ref.read(navigatorProvider).goNamed(WelcomeViewRoute.name);
    } else {
      ref.read(navigatorProvider).goNamed(HomePageRoute.name);
    }
  }
}
