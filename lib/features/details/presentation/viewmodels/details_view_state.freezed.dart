// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DetailsViewState {
  String get selectedColor => throw _privateConstructorUsedError;
  List<DetailItem> get items => throw _privateConstructorUsedError;
  bool get isAddingItem => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of DetailsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailsViewStateCopyWith<DetailsViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailsViewStateCopyWith<$Res> {
  factory $DetailsViewStateCopyWith(
    DetailsViewState value,
    $Res Function(DetailsViewState) then,
  ) = _$DetailsViewStateCopyWithImpl<$Res, DetailsViewState>;
  @useResult
  $Res call({
    String selectedColor,
    List<DetailItem> items,
    bool isAddingItem,
    bool isLoading,
    String? errorMessage,
    String? successMessage,
  });
}

/// @nodoc
class _$DetailsViewStateCopyWithImpl<$Res, $Val extends DetailsViewState>
    implements $DetailsViewStateCopyWith<$Res> {
  _$DetailsViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedColor = null,
    Object? items = null,
    Object? isAddingItem = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedColor: null == selectedColor
                ? _value.selectedColor
                : selectedColor // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DetailItem>,
            isAddingItem: null == isAddingItem
                ? _value.isAddingItem
                : isAddingItem // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$DetailsViewStateImplCopyWith<$Res>
    implements $DetailsViewStateCopyWith<$Res> {
  factory _$$DetailsViewStateImplCopyWith(
    _$DetailsViewStateImpl value,
    $Res Function(_$DetailsViewStateImpl) then,
  ) = __$$DetailsViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String selectedColor,
    List<DetailItem> items,
    bool isAddingItem,
    bool isLoading,
    String? errorMessage,
    String? successMessage,
  });
}

/// @nodoc
class __$$DetailsViewStateImplCopyWithImpl<$Res>
    extends _$DetailsViewStateCopyWithImpl<$Res, _$DetailsViewStateImpl>
    implements _$$DetailsViewStateImplCopyWith<$Res> {
  __$$DetailsViewStateImplCopyWithImpl(
    _$DetailsViewStateImpl _value,
    $Res Function(_$DetailsViewStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedColor = null,
    Object? items = null,
    Object? isAddingItem = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$DetailsViewStateImpl(
        selectedColor: null == selectedColor
            ? _value.selectedColor
            : selectedColor // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DetailItem>,
        isAddingItem: null == isAddingItem
            ? _value.isAddingItem
            : isAddingItem // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$DetailsViewStateImpl extends _DetailsViewState {
  const _$DetailsViewStateImpl({
    this.selectedColor = 'Blue',
    final List<DetailItem> items = const <DetailItem>[],
    this.isAddingItem = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  }) : _items = items,
       super._();

  @override
  @JsonKey()
  final String selectedColor;
  final List<DetailItem> _items;
  @override
  @JsonKey()
  List<DetailItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool isAddingItem;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'DetailsViewState(selectedColor: $selectedColor, items: $items, isAddingItem: $isAddingItem, isLoading: $isLoading, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailsViewStateImpl &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isAddingItem, isAddingItem) ||
                other.isAddingItem == isAddingItem) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedColor,
    const DeepCollectionEquality().hash(_items),
    isAddingItem,
    isLoading,
    errorMessage,
    successMessage,
  );

  /// Create a copy of DetailsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailsViewStateImplCopyWith<_$DetailsViewStateImpl> get copyWith =>
      __$$DetailsViewStateImplCopyWithImpl<_$DetailsViewStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DetailsViewState extends DetailsViewState {
  const factory _DetailsViewState({
    final String selectedColor,
    final List<DetailItem> items,
    final bool isAddingItem,
    final bool isLoading,
    final String? errorMessage,
    final String? successMessage,
  }) = _$DetailsViewStateImpl;
  const _DetailsViewState._() : super._();

  @override
  String get selectedColor;
  @override
  List<DetailItem> get items;
  @override
  bool get isAddingItem;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of DetailsViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailsViewStateImplCopyWith<_$DetailsViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
