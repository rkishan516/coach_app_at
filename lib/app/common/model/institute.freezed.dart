// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Institute _$InstituteFromJson(Map<String, dynamic> json) {
  return _Institute.fromJson(json);
}

/// @nodoc
mixin _$Institute {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InstituteCopyWith<Institute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstituteCopyWith<$Res> {
  factory $InstituteCopyWith(Institute value, $Res Function(Institute) then) =
      _$InstituteCopyWithImpl<$Res, Institute>;
  @useResult
  $Res call({String name, String? description, String? website});
}

/// @nodoc
class _$InstituteCopyWithImpl<$Res, $Val extends Institute>
    implements $InstituteCopyWith<$Res> {
  _$InstituteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? website = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstituteImplCopyWith<$Res>
    implements $InstituteCopyWith<$Res> {
  factory _$$InstituteImplCopyWith(
          _$InstituteImpl value, $Res Function(_$InstituteImpl) then) =
      __$$InstituteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description, String? website});
}

/// @nodoc
class __$$InstituteImplCopyWithImpl<$Res>
    extends _$InstituteCopyWithImpl<$Res, _$InstituteImpl>
    implements _$$InstituteImplCopyWith<$Res> {
  __$$InstituteImplCopyWithImpl(
      _$InstituteImpl _value, $Res Function(_$InstituteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? website = freezed,
  }) {
    return _then(_$InstituteImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InstituteImpl extends _Institute {
  const _$InstituteImpl({required this.name, this.description, this.website})
      : super._();

  factory _$InstituteImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstituteImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final String? website;

  @override
  String toString() {
    return 'Institute(name: $name, description: $description, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstituteImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, website);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InstituteImplCopyWith<_$InstituteImpl> get copyWith =>
      __$$InstituteImplCopyWithImpl<_$InstituteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstituteImplToJson(
      this,
    );
  }
}

abstract class _Institute extends Institute {
  const factory _Institute(
      {required final String name,
      final String? description,
      final String? website}) = _$InstituteImpl;
  const _Institute._() : super._();

  factory _Institute.fromJson(Map<String, dynamic> json) =
      _$InstituteImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  String? get website;
  @override
  @JsonKey(ignore: true)
  _$$InstituteImplCopyWith<_$InstituteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
