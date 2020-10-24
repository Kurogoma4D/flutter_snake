import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_state.freezed.dart';

enum InputDirection { none, left, up, right, down }

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default([]) List<Offset> snake,
    @Default(InputDirection.none) InputDirection currentDirection,
    @Default(Offset.zero) Offset player,
  }) = _AppState;
}
