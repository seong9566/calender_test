// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CalendarResponseModel _$CalendarResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _CalendarResponseModel.fromJson(json);
}

/// @nodoc
mixin _$CalendarResponseModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  Color get color => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;

  /// Serializes this CalendarResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarResponseModelCopyWith<CalendarResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarResponseModelCopyWith<$Res> {
  factory $CalendarResponseModelCopyWith(
    CalendarResponseModel value,
    $Res Function(CalendarResponseModel) then,
  ) = _$CalendarResponseModelCopyWithImpl<$Res, CalendarResponseModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    @JsonKey(includeToJson: false, includeFromJson: false) Color color,
    bool isAllDay,
  });
}

/// @nodoc
class _$CalendarResponseModelCopyWithImpl<
  $Res,
  $Val extends CalendarResponseModel
>
    implements $CalendarResponseModelCopyWith<$Res> {
  _$CalendarResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = null,
    Object? isAllDay = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as Color,
            isAllDay: null == isAllDay
                ? _value.isAllDay
                : isAllDay // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalendarResponseModelImplCopyWith<$Res>
    implements $CalendarResponseModelCopyWith<$Res> {
  factory _$$CalendarResponseModelImplCopyWith(
    _$CalendarResponseModelImpl value,
    $Res Function(_$CalendarResponseModelImpl) then,
  ) = __$$CalendarResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    @JsonKey(includeToJson: false, includeFromJson: false) Color color,
    bool isAllDay,
  });
}

/// @nodoc
class __$$CalendarResponseModelImplCopyWithImpl<$Res>
    extends
        _$CalendarResponseModelCopyWithImpl<$Res, _$CalendarResponseModelImpl>
    implements _$$CalendarResponseModelImplCopyWith<$Res> {
  __$$CalendarResponseModelImplCopyWithImpl(
    _$CalendarResponseModelImpl _value,
    $Res Function(_$CalendarResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = null,
    Object? isAllDay = null,
  }) {
    return _then(
      _$CalendarResponseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as Color,
        isAllDay: null == isAllDay
            ? _value.isAllDay
            : isAllDay // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarResponseModelImpl extends _CalendarResponseModel {
  const _$CalendarResponseModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    @JsonKey(includeToJson: false, includeFromJson: false)
    this.color = Colors.blue,
    this.isAllDay = false,
  }) : super._();

  factory _$CalendarResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarResponseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Color color;
  @override
  @JsonKey()
  final bool isAllDay;

  @override
  String toString() {
    return 'CalendarResponseModel(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, color: $color, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    startTime,
    endTime,
    color,
    isAllDay,
  );

  /// Create a copy of CalendarResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarResponseModelImplCopyWith<_$CalendarResponseModelImpl>
  get copyWith =>
      __$$CalendarResponseModelImplCopyWithImpl<_$CalendarResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarResponseModelImplToJson(this);
  }
}

abstract class _CalendarResponseModel extends CalendarResponseModel {
  const factory _CalendarResponseModel({
    required final String id,
    required final String title,
    required final String description,
    required final DateTime startTime,
    required final DateTime endTime,
    @JsonKey(includeToJson: false, includeFromJson: false) final Color color,
    final bool isAllDay,
  }) = _$CalendarResponseModelImpl;
  const _CalendarResponseModel._() : super._();

  factory _CalendarResponseModel.fromJson(Map<String, dynamic> json) =
      _$CalendarResponseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  Color get color;
  @override
  bool get isAllDay;

  /// Create a copy of CalendarResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarResponseModelImplCopyWith<_$CalendarResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
