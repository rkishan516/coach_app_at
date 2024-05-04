import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const Course._();
  const factory Course({
    required String instituteId,
    required String name,
    required String description,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
