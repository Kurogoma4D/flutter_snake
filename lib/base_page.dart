import 'package:flutter/material.dart';
import 'package:flutter_snake/app_state/app_state_controller.dart';
import 'package:flutter_snake/game_board.dart';
import 'package:flutter_snake/game_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _focus = FocusNode();

class BasePage extends StatelessWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focus,
        autofocus: true,
        onKey: (event) => context
            .read(appStateControllerProvider)
            .processKeyEvent(event.logicalKey.keyId),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: const GameBoard(),
                      ),
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
      ),
    );
  }
}
