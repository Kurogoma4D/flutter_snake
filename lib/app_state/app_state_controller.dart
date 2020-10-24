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

  Offset _getNextPosition(Offset origin, Offset moveAmount) {
    return Offset(
      (origin.dx + moveAmount.dx) % BOARD_SIZE,
      (origin.dy + moveAmount.dy) % BOARD_SIZE,
    );
  }

  Offset _mapDirectionToOffset(InputDirection direction) {
    switch (direction) {
      case InputDirection.left:
        return Offset(-1, 0);
      case InputDirection.up:
        return Offset(0, -1);
      case InputDirection.right:
        return Offset(1, 0);
      case InputDirection.down:
        return Offset(0, 1);
      case InputDirection.none:
      default:
        return Offset.zero;
    }
  }

  void _updatePlayer() {
    final moveAmount = _mapDirectionToOffset(state.currentDirection);
    state = state.copyWith(player: _getNextPosition(state.player, moveAmount));
  }

  void updateGameState() {
    _updatePlayer();
  }
}
