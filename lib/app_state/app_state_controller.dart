import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/app_state/app_state.dart';
import 'package:flutter_snake/game_board.dart';

final _random = math.Random();

final appStateControllerProvider = Provider((ref) => AppStateController(
      state: AppState(
        player: Offset(
          _random.nextInt(BOARD_SIZE).toDouble(),
          _random.nextInt(BOARD_SIZE).toDouble(),
        ),
      ),
    ));

class AppStateController {
  AppState state;

  AppStateController({this.state});

  void setDirection(InputDirection value) {
    state = state.copyWith(currentDirection: value);
  }
}
