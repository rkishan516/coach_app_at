// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shiksha_dhra/app/common/notifiers/current_user_state_notifier.dart';

part 'shikhsha_dhra_user.freezed.dart';
part 'shikhsha_dhra_user.g.dart';

@freezed
class ShikshaDhraUser with _$ShikshaDhraUser {
  const ShikshaDhraUser._();
  const factory ShikshaDhraUser({
    required String name,
    required String email,
    String? instituteId,
    required Role role,
  }) = _ShikshaDhraUser;

  factory ShikshaDhraUser.fromJson(Map<String, dynamic> json) =>
      _$ShikshaDhraUserFromJson(json);
}
