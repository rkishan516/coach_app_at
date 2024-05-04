// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserCourse _$UserCourseFromJson(Map<String, dynamic> json) {
  return _UserCourse.fromJson(json);
}

/// @nodoc
mixin _$UserCourse {
  String get userId => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCourseCopyWith<UserCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCourseCopyWith<$Res> {
  factory $UserCourseCopyWith(
          UserCourse value, $Res Function(UserCourse) then) =
      _$UserCourseCopyWithImpl<$Res, UserCourse>;
  @useResult
  $Res call({String userId, String courseId});
}

/// @nodoc
class _$UserCourseCopyWithImpl<$Res, $Val extends UserCourse>
    implements $UserCourseCopyWith<$Res> {
  _$UserCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCourseImplCopyWith<$Res>
    implements $UserCourseCopyWith<$Res> {
  factory _$$UserCourseImplCopyWith(
          _$UserCourseImpl value, $Res Function(_$UserCourseImpl) then) =
      __$$UserCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String courseId});
}

/// @nodoc
class __$$UserCourseImplCopyWithImpl<$Res>
    extends _$UserCourseCopyWithImpl<$Res, _$UserCourseImpl>
    implements _$$UserCourseImplCopyWith<$Res> {
  __$$UserCourseImplCopyWithImpl(
      _$UserCourseImpl _value, $Res Function(_$UserCourseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
  }) {
    return _then(_$UserCourseImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCourseImpl extends _UserCourse {
  const _$UserCourseImpl({required this.userId, required this.courseId})
      : super._();

  factory _$UserCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCourseImplFromJson(json);

  @override
  final String userId;
  @override
  final String courseId;

  @override
  String toString() {
    return 'UserCourse(userId: $userId, courseId: $courseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCourseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, courseId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCourseImplCopyWith<_$UserCourseImpl> get copyWith =>
      __$$UserCourseImplCopyWithImpl<_$UserCourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCourseImplToJson(
      this,
    );
  }
}

abstract class _UserCourse extends UserCourse {
  const factory _UserCourse(
      {required final String userId,
      required final String courseId}) = _$UserCourseImpl;
  const _UserCourse._() : super._();

  factory _UserCourse.fromJson(Map<String, dynamic> json) =
      _$UserCourseImpl.fromJson;

  @override
  String get userId;
  @override
  String get courseId;
  @override
  @JsonKey(ignore: true)
  _$$UserCourseImplCopyWith<_$UserCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
