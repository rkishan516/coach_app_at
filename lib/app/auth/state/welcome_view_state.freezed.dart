// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welcome_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WelcomeViewState {
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WelcomeViewStateCopyWith<WelcomeViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WelcomeViewStateCopyWith<$Res> {
  factory $WelcomeViewStateCopyWith(
          WelcomeViewState value, $Res Function(WelcomeViewState) then) =
      _$WelcomeViewStateCopyWithImpl<$Res, WelcomeViewState>;
  @useResult
  $Res call({bool loading});
}

/// @nodoc
class _$WelcomeViewStateCopyWithImpl<$Res, $Val extends WelcomeViewState>
    implements $WelcomeViewStateCopyWith<$Res> {
  _$WelcomeViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WelcomeViewStateImplCopyWith<$Res>
    implements $WelcomeViewStateCopyWith<$Res> {
  factory _$$WelcomeViewStateImplCopyWith(_$WelcomeViewStateImpl value,
          $Res Function(_$WelcomeViewStateImpl) then) =
      __$$WelcomeViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading});
}

/// @nodoc
class __$$WelcomeViewStateImplCopyWithImpl<$Res>
    extends _$WelcomeViewStateCopyWithImpl<$Res, _$WelcomeViewStateImpl>
    implements _$$WelcomeViewStateImplCopyWith<$Res> {
  __$$WelcomeViewStateImplCopyWithImpl(_$WelcomeViewStateImpl _value,
      $Res Function(_$WelcomeViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
  }) {
    return _then(_$WelcomeViewStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WelcomeViewStateImpl implements _WelcomeViewState {
  const _$WelcomeViewStateImpl({required this.loading});

  @override
  final bool loading;

  @override
  String toString() {
    return 'WelcomeViewState(loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WelcomeViewStateImpl &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WelcomeViewStateImplCopyWith<_$WelcomeViewStateImpl> get copyWith =>
      __$$WelcomeViewStateImplCopyWithImpl<_$WelcomeViewStateImpl>(
          this, _$identity);
}

abstract class _WelcomeViewState implements WelcomeViewState {
  const factory _WelcomeViewState({required final bool loading}) =
      _$WelcomeViewStateImpl;

  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$WelcomeViewStateImplCopyWith<_$WelcomeViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
