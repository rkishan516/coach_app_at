import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const Content._();
  const factory Content({
    required String subjectId,
    required String type,
    required String title,
    required String data,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
