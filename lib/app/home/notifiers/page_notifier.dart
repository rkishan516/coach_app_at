import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/home/state/page_state.dart';

part 'page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  @override
  HomePageState build() {
    return const HomePageState(counter: 0);
  }

  void incrementCounter() {
    state = state.copyWith(counter: state.counter + 1);
  }

  void logout() async {
    await ref.read(appwriteAuthServiceProvider).logout();
  }
}
