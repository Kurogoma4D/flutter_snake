// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call(
      {List<Offset> snake = const [],
      InputDirection currentDirection = InputDirection.none,
      Offset player = Offset.zero}) {
    return _AppState(
      snake: snake,
      currentDirection: currentDirection,
      player: player,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  List<Offset> get snake;
  InputDirection get currentDirection;
  Offset get player;

  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call(
      {List<Offset> snake, InputDirection currentDirection, Offset player});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object snake = freezed,
    Object currentDirection = freezed,
    Object player = freezed,
  }) {
    return _then(_value.copyWith(
      snake: snake == freezed ? _value.snake : snake as List<Offset>,
      currentDirection: currentDirection == freezed
          ? _value.currentDirection
          : currentDirection as InputDirection,
      player: player == freezed ? _value.player : player as Offset,
    ));
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Offset> snake, InputDirection currentDirection, Offset player});
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(_AppState _value, $Res Function(_AppState) _then)
      : super(_value, (v) => _then(v as _AppState));

  @override
  _AppState get _value => super._value as _AppState;

  @override
  $Res call({
    Object snake = freezed,
    Object currentDirection = freezed,
    Object player = freezed,
  }) {
    return _then(_AppState(
      snake: snake == freezed ? _value.snake : snake as List<Offset>,
      currentDirection: currentDirection == freezed
          ? _value.currentDirection
          : currentDirection as InputDirection,
      player: player == freezed ? _value.player : player as Offset,
    ));
  }
}

/// @nodoc
class _$_AppState with DiagnosticableTreeMixin implements _AppState {
  const _$_AppState(
      {this.snake = const [],
      this.currentDirection = InputDirection.none,
      this.player = Offset.zero})
      : assert(snake != null),
        assert(currentDirection != null),
        assert(player != null);

  @JsonKey(defaultValue: const [])
  @override
  final List<Offset> snake;
  @JsonKey(defaultValue: InputDirection.none)
  @override
  final InputDirection currentDirection;
  @JsonKey(defaultValue: Offset.zero)
  @override
  final Offset player;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(snake: $snake, currentDirection: $currentDirection, player: $player)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('snake', snake))
      ..add(DiagnosticsProperty('currentDirection', currentDirection))
      ..add(DiagnosticsProperty('player', player));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.snake, snake) ||
                const DeepCollectionEquality().equals(other.snake, snake)) &&
            (identical(other.currentDirection, currentDirection) ||
                const DeepCollectionEquality()
                    .equals(other.currentDirection, currentDirection)) &&
            (identical(other.player, player) ||
                const DeepCollectionEquality().equals(other.player, player)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(snake) ^
      const DeepCollectionEquality().hash(currentDirection) ^
      const DeepCollectionEquality().hash(player);

  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {List<Offset> snake,
      InputDirection currentDirection,
      Offset player}) = _$_AppState;

  @override
  List<Offset> get snake;
  @override
  InputDirection get currentDirection;
  @override
  Offset get player;
  @override
  _$AppStateCopyWith<_AppState> get copyWith;
}
