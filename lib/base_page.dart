import 'package:flutter/material.dart';
import 'package:flutter_snake/game_board.dart';
import 'package:flutter_snake/game_controller.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  child: const GameBoard(),
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
    );
  }
}
