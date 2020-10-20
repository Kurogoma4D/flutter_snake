import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

enum InputDirection { none, left, up, right, down }

final snakeLengthProvider = StateProvider((_) => 1);
final directionProvider = StateProvider((_) => InputDirection.none);
final playerCoordProvider = StateProvider((_) => Offset.zero);

const BOARD_SIZE = 15;

class GameBoard extends ConsumerWidget {
  const GameBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final length = watch(snakeLengthProvider);
    final direction = watch(directionProvider);
    final player = watch(playerCoordProvider);
    return RepaintBoundary(
      child: CustomPaint(
        painter: BoardPainter(
          player: player.state,
          direction: direction.state,
          snakeLength: length.state,
        ),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  final Offset player;
  final InputDirection direction;
  final int snakeLength;

  static final borderPaint = Paint()
    ..color = Colors.black87
    ..strokeWidth = 2.0;

  BoardPainter({this.player, this.direction, this.snakeLength});

  @override
  void paint(Canvas canvas, Size size) {
    drawBoard(canvas, size);
  }

  void drawBoard(Canvas canvas, Size size) {
    final gridSize = size.width / BOARD_SIZE;
    // draw row
    for (int i = 0; i < BOARD_SIZE + 1; i++) {
      canvas.drawLine(Offset(0.0, i * gridSize),
          Offset(size.width, i * gridSize), borderPaint);
    }

    // draw column
    for (int i = 0; i < BOARD_SIZE + 1; i++) {
      canvas.drawLine(Offset(i * gridSize, 0.0),
          Offset(i * gridSize, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) =>
      player != oldDelegate.player;
}
