// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SettingsViewState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of SettingsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsViewStateCopyWith<SettingsViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsViewStateCopyWith<$Res> {
  factory $SettingsViewStateCopyWith(
    SettingsViewState value,
    $Res Function(SettingsViewState) then,
  ) = _$SettingsViewStateCopyWithImpl<$Res, SettingsViewState>;
  @useResult
  $Res call({bool isLoading, String? errorMessage, String? successMessage});
}

/// @nodoc
class _$SettingsViewStateCopyWithImpl<$Res, $Val extends SettingsViewState>
    implements $SettingsViewStateCopyWith<$Res> {
  _$SettingsViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingsViewStateImplCopyWith<$Res>
    implements $SettingsViewStateCopyWith<$Res> {
  factory _$$SettingsViewStateImplCopyWith(
    _$SettingsViewStateImpl value,
    $Res Function(_$SettingsViewStateImpl) then,
  ) = __$$SettingsViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorMessage, String? successMessage});
}

/// @nodoc
class __$$SettingsViewStateImplCopyWithImpl<$Res>
    extends _$SettingsViewStateCopyWithImpl<$Res, _$SettingsViewStateImpl>
    implements _$$SettingsViewStateImplCopyWith<$Res> {
  __$$SettingsViewStateImplCopyWithImpl(
    _$SettingsViewStateImpl _value,
    $Res Function(_$SettingsViewStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$SettingsViewStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SettingsViewStateImpl extends _SettingsViewState {
  const _$SettingsViewStateImpl({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  }) : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'SettingsViewState(isLoading: $isLoading, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsViewStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorMessage, successMessage);

  /// Create a copy of SettingsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsViewStateImplCopyWith<_$SettingsViewStateImpl> get copyWith =>
      __$$SettingsViewStateImplCopyWithImpl<_$SettingsViewStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SettingsViewState extends SettingsViewState {
  const factory _SettingsViewState({
    final bool isLoading,
    final String? errorMessage,
    final String? successMessage,
  }) = _$SettingsViewStateImpl;
  const _SettingsViewState._() : super._();

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of SettingsViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsViewStateImplCopyWith<_$SettingsViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
