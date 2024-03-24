import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_view_state.freezed.dart';

@freezed
class WelcomeViewState with _$WelcomeViewState {
  const factory WelcomeViewState({
    required bool loading,
  }) = _WelcomeViewState;
}
