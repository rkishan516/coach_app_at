import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/auth/state/welcome_view_state.dart';

part 'welcome_view_notifier.g.dart';

@riverpod
class WelcomeNotifier extends _$WelcomeNotifier {
  @override
  WelcomeViewState build() {
    return const WelcomeViewState(loading: false);
  }

  Future<void> logInWithGoogle() async {
    state = state.copyWith(loading: true);
    await ref.read(appwriteAuthServiceProvider).signInWithGoogleAppWrite();
    state = state.copyWith(loading: true);
  }
}
