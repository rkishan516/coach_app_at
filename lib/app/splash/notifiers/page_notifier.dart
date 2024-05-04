import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/common/notifiers/current_user_state_notifier.dart';
import 'package:shiksha_dhra/app/routes/notifiers/app_router.dart';
import 'package:shiksha_dhra/app/routes/notifiers/app_routes.dart';

part 'page_notifier.g.dart';

@riverpod
class SplashPageNotifier extends _$SplashPageNotifier {
  @override
  void build() {
    return;
  }

  Future<void> runStartUpLogic() async {
    final user =
        await ref.read(currentUserStateNotifierProvider.notifier).load();
    await ref.read(sikhshaDhraUserNotifierProvider.notifier).load();
    if (user == null) {
      ref.read(navigatorProvider).goNamed(WelcomeViewRoute.name);
    } else {
      ref.read(navigatorProvider).goNamed(HomePageRoute.name);
    }
  }
}
