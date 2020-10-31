import 'package:flutter/material.dart';
import 'package:flutter_snake/app_state/app_state_controller.dart';
import 'package:flutter_snake/game_board.dart';
import 'package:flutter_snake/game_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _focus = FocusNode();

final rebuildOptimizeFlagProvider = StateProvider((_) => false);

class BasePage extends ConsumerWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isOptimized = watch(rebuildOptimizeFlagProvider).state;

    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focus,
        autofocus: true,
        onKey: (event) => context
            .read(appStateControllerProvider)
            .processKeyEvent(event.logicalKey.keyId),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 7,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: isOptimized
                              ? const RebuildOptimizedGameBoard()
                              : Container(),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: const GameController(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Switch(
              value: isOptimized,
              onChanged: (value) =>
                  context.read(rebuildOptimizeFlagProvider).state = value,
            )
          ],
        ),
      ),
    );
  }
}
