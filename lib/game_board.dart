import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_snake/app_state/app_state_controller.dart';

const BOARD_SIZE = 15;

final clockProvider = StreamProvider<int>((ref) async* {
  final baseStream =
      Stream<int>.periodic(const Duration(milliseconds: 120), (c) => c);

  await for (final value in baseStream) {
    yield value;
  }
});

class GameBoard extends ConsumerWidget {
  const GameBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final clock = watch(clockProvider);
    final controller = watch(appStateControllerProvider);

    return clock.when(
      data: (value) => _Contents(
        snake: controller.state.snake,
        item: controller.state.item,
      ),
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

class _Contents extends StatelessWidget {
  const _Contents({
    Key key,
    this.item,
    this.snake,
  }) : super(key: key);

  final List<Offset> snake;
  final Offset item;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final gridSize = constraint.maxWidth / BOARD_SIZE;
        return Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: BOARD_SIZE,
              ),
              itemCount: BOARD_SIZE * BOARD_SIZE,
              itemBuilder: (context, index) => Container(
                color: index.isEven
                    ? Colors.green.withOpacity(0.4)
                    : Colors.lightGreen.withOpacity(0.4),
              ),
            ),
            Positioned(
              top: item.dy * gridSize,
              left: item.dx * gridSize,
              child: Container(
                width: gridSize,
                height: gridSize,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            for (final element in snake)
              Positioned(
                top: element.dy * gridSize,
                left: element.dx * gridSize,
                child: Container(
                  width: gridSize,
                  height: gridSize,
                  decoration: BoxDecoration(
                    color: snake.indexOf(element) == 0
                        ? Colors.lightBlue
                        : Colors.lightBlueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
