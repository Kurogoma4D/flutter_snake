import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/app_state/app_state.dart';
import 'package:flutter_snake/game_board.dart';

enum GameState {
  initial,
  running,
  finished,
}

class KeyInput {
  static const arrowLeft = 4295426128;
  static const arrowUp = 4295426130;
  static const arrowRight = 4295426127;
  static const arrowDown = 4295426129;
}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState.initial);
}

final gameStateProvider = StateNotifierProvider((_) => GameStateNotifier());

final _random = math.Random();

final appStateControllerProvider = Provider((ref) => AppStateController(
      state: AppState(
        snake: [
          Offset(
            _random.nextInt(BOARD_SIZE).toDouble(),
            _random.nextInt(BOARD_SIZE).toDouble(),
          ),
        ],
        item: Offset(
          _random.nextInt(BOARD_SIZE).toDouble(),
          _random.nextInt(BOARD_SIZE).toDouble(),
        ),
      ),
      ref: ref,
    ));

class AppStateController {
  AppState state;
  StreamSubscription clock;

  AppStateController({this.state, ProviderReference ref}) {
    clock = ref.read(clockProvider.stream).listen((_) {
      _updateGameState();
    });

    ref.read(gameStateProvider).stream.listen((state) {
      switch (state) {
        case GameState.initial:
          break;
        case GameState.running:
          break;
        case GameState.finished:
          clock.cancel();
          break;
      }
    });
  }

  void processKeyEvent(int keyId) {
    final direction = _mapKeyInputToDirection(keyId);
    if (direction != InputDirection.none) setDirection(direction);
  }

  InputDirection _mapKeyInputToDirection(int keyId) {
    switch (keyId) {
      case KeyInput.arrowLeft:
        return InputDirection.left;
      case KeyInput.arrowUp:
        return InputDirection.up;
      case KeyInput.arrowRight:
        return InputDirection.right;
      case KeyInput.arrowDown:
        return InputDirection.down;
      default:
        return InputDirection.none;
    }
  }

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

  void _addTrail() {
    state = state.copyWith(
      snake: [...state.snake, state.snake.first],
    );
  }

  void _updatePlayer() {
    final moveAmount = _mapDirectionToOffset(state.currentDirection);
    final playerPosition = _getNextPosition(state.snake.first, moveAmount);

    state = state.copyWith(
      snake: [
        playerPosition,
        ...state.snake.getRange(0, state.snake.length - 1)
      ],
    );
  }

  void _updateGameState() {
    _updatePlayer();

    if (state.snake.first == state.item) {
      _addTrail();
      state = state.copyWith(
          item: Offset(
        _random.nextInt(BOARD_SIZE).toDouble(),
        _random.nextInt(BOARD_SIZE).toDouble(),
      ));
    }
  }
}
