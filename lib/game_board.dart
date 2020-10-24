import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_snake/app_state/app_state.dart';
import 'package:flutter_snake/app_state/app_state_controller.dart';

const BOARD_SIZE = 15;

final clockProvider = StreamProvider.autoDispose<int>((ref) async* {
  final baseStream =
      Stream<int>.periodic(const Duration(milliseconds: 200), (c) => c);
  bool _enabled = true;
  ref.onDispose(() => _enabled = false);

  await for (final value in baseStream) {
    if (_enabled) yield value;
  }
});

class GameBoard extends ConsumerWidget {
  const GameBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final clock = watch(clockProvider);
    final controller = watch(appStateControllerProvider);

    return clock.when(
      data: (value) {
        controller.updateGameState();
        return RepaintBoundary(
          child: CustomPaint(
            painter: BoardPainter(
              direction: controller.state.currentDirection,
              snake: controller.state.snake,
              item: controller.state.item,
            ),
          ),
        );
      },
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

class BoardPainter extends CustomPainter {
  final InputDirection direction;
  final List<Offset> snake;
  final Offset item;

  static final borderPaint = Paint()
    ..color = Colors.black87
    ..strokeWidth = 2.0;

  static final innerBorderPaint = Paint()
    ..color = Colors.black26
    ..strokeWidth = 2.0;

  static final playerPaint = Paint()..color = Colors.lightBlue;
  static final snakePaint = Paint()..color = Colors.lightBlueAccent;
  static final itemPaint = Paint()..color = Colors.orange;

  BoardPainter({this.item, this.direction, this.snake});

  @override
  void paint(Canvas canvas, Size size) {
    final gridSize = size.width / BOARD_SIZE;

    drawBoard(canvas, size, gridSize);
    drawItem(canvas, size, gridSize);
    drawPlayer(canvas, size, gridSize);
  }

  void drawBoard(Canvas canvas, Size size, double gridSize) {
    // draw row
    for (int i = 0; i < BOARD_SIZE + 1; i++) {
      canvas.drawLine(
        Offset(0.0, i * gridSize),
        Offset(size.width, i * gridSize),
        i % BOARD_SIZE == 0 ? borderPaint : innerBorderPaint,
      );
    }

    // draw column
    for (int i = 0; i < BOARD_SIZE + 1; i++) {
      canvas.drawLine(
        Offset(i * gridSize, 0.0),
        Offset(i * gridSize, size.height),
        i % BOARD_SIZE == 0 ? borderPaint : innerBorderPaint,
      );
    }
  }

  void drawPlayer(Canvas canvas, Size size, double gridSize) {
    canvas.drawCircle(
        (snake.first / BOARD_SIZE.toDouble() * size.width)
            .translate(gridSize / 2, gridSize / 2),
        gridSize / 2,
        playerPaint);

    final body = snake.getRange(1, snake.length);

    for (final element in body) {
      canvas.drawCircle(
          (element / BOARD_SIZE.toDouble() * size.width)
              .translate(gridSize / 2, gridSize / 2),
          gridSize / 2,
          snakePaint);
    }
  }

  void drawItem(Canvas canvas, Size size, double gridSize) {
    canvas.drawCircle(
        (item / BOARD_SIZE.toDouble() * size.width)
            .translate(gridSize / 2, gridSize / 2),
        gridSize / 2,
        itemPaint);
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) => true;
}
