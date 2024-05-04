import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
class Subject with _$Subject {
  const Subject._();
  const factory Subject({
    required String name,
    required String courseId,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
