import 'package:riverpod_annotation/riverpod_annotation.dart';
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
}
