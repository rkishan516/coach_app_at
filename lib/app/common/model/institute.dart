import 'package:freezed_annotation/freezed_annotation.dart';

part 'institute.freezed.dart';
part 'institute.g.dart';

@freezed
class Institute with _$Institute {
  const Institute._();
  const factory Institute({
    required String name,
    String? description,
    String? website,
  }) = _Institute;

  factory Institute.fromJson(Map<String, dynamic> json) =>
      _$InstituteFromJson(json);
}
