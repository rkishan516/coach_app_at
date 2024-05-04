// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_course.freezed.dart';
part 'user_course.g.dart';

@freezed
class UserCourse with _$UserCourse {
  const UserCourse._();
  const factory UserCourse({
    required String userId,
    required String courseId,
  }) = _UserCourse;

  factory UserCourse.fromJson(Map<String, dynamic> json) =>
      _$UserCourseFromJson(json);
}
