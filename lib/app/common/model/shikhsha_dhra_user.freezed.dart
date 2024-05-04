// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shikhsha_dhra_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShikshaDhraUser _$ShikshaDhraUserFromJson(Map<String, dynamic> json) {
  return _ShikshaDhraUser.fromJson(json);
}

/// @nodoc
mixin _$ShikshaDhraUser {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get instituteId => throw _privateConstructorUsedError;
  Role get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShikshaDhraUserCopyWith<ShikshaDhraUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShikshaDhraUserCopyWith<$Res> {
  factory $ShikshaDhraUserCopyWith(
          ShikshaDhraUser value, $Res Function(ShikshaDhraUser) then) =
      _$ShikshaDhraUserCopyWithImpl<$Res, ShikshaDhraUser>;
  @useResult
  $Res call({String name, String email, String? instituteId, Role role});
}

/// @nodoc
class _$ShikshaDhraUserCopyWithImpl<$Res, $Val extends ShikshaDhraUser>
    implements $ShikshaDhraUserCopyWith<$Res> {
  _$ShikshaDhraUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? instituteId = freezed,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      instituteId: freezed == instituteId
          ? _value.instituteId
          : instituteId // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShikshaDhraUserImplCopyWith<$Res>
    implements $ShikshaDhraUserCopyWith<$Res> {
  factory _$$ShikshaDhraUserImplCopyWith(_$ShikshaDhraUserImpl value,
          $Res Function(_$ShikshaDhraUserImpl) then) =
      __$$ShikshaDhraUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String email, String? instituteId, Role role});
}

/// @nodoc
class __$$ShikshaDhraUserImplCopyWithImpl<$Res>
    extends _$ShikshaDhraUserCopyWithImpl<$Res, _$ShikshaDhraUserImpl>
    implements _$$ShikshaDhraUserImplCopyWith<$Res> {
  __$$ShikshaDhraUserImplCopyWithImpl(
      _$ShikshaDhraUserImpl _value, $Res Function(_$ShikshaDhraUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? instituteId = freezed,
    Object? role = null,
  }) {
    return _then(_$ShikshaDhraUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      instituteId: freezed == instituteId
          ? _value.instituteId
          : instituteId // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShikshaDhraUserImpl extends _ShikshaDhraUser {
  const _$ShikshaDhraUserImpl(
      {required this.name,
      required this.email,
      this.instituteId,
      required this.role})
      : super._();

  factory _$ShikshaDhraUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShikshaDhraUserImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String? instituteId;
  @override
  final Role role;

  @override
  String toString() {
    return 'ShikshaDhraUser(name: $name, email: $email, instituteId: $instituteId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShikshaDhraUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.instituteId, instituteId) ||
                other.instituteId == instituteId) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, instituteId, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShikshaDhraUserImplCopyWith<_$ShikshaDhraUserImpl> get copyWith =>
      __$$ShikshaDhraUserImplCopyWithImpl<_$ShikshaDhraUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShikshaDhraUserImplToJson(
      this,
    );
  }
}

abstract class _ShikshaDhraUser extends ShikshaDhraUser {
  const factory _ShikshaDhraUser(
      {required final String name,
      required final String email,
      final String? instituteId,
      required final Role role}) = _$ShikshaDhraUserImpl;
  const _ShikshaDhraUser._() : super._();

  factory _ShikshaDhraUser.fromJson(Map<String, dynamic> json) =
      _$ShikshaDhraUserImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String? get instituteId;
  @override
  Role get role;
  @override
  @JsonKey(ignore: true)
  _$$ShikshaDhraUserImplCopyWith<_$ShikshaDhraUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
