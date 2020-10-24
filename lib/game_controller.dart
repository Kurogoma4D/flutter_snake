import 'package:flutter/material.dart';
import 'package:flutter_snake/app_state/app_state.dart';
import 'package:flutter_snake/app_state/app_state_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const BUTTON_SIZE = 48.0;

class GameController extends StatelessWidget {
  const GameController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _DirectionButton(direction: InputDirection.up),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DirectionButton(direction: InputDirection.left),
              const SizedBox(width: BUTTON_SIZE),
              _DirectionButton(direction: InputDirection.right),
            ],
          ),
          _DirectionButton(direction: InputDirection.down),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatefulWidget {
  const _DirectionButton({Key key, @required this.direction}) : super(key: key);

  final InputDirection direction;

  @override
  __DirectionButtonState createState() => __DirectionButtonState();
}

class __DirectionButtonState extends State<_DirectionButton> {
  bool isPressed = false;

  String getButtonText() {
    switch (widget.direction) {
      case InputDirection.left:
        return '←';
      case InputDirection.up:
        return '↑';
      case InputDirection.right:
        return '→';
      case InputDirection.down:
        return '↓';
      case InputDirection.none:
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () => context
          .read(appStateControllerProvider)
          .setDirection(widget.direction),
      child: _DirectionButtonView(
        text: getButtonText(),
        isPressed: isPressed,
      ),
    );
  }
}

class _DirectionButtonView extends StatelessWidget {
  const _DirectionButtonView({Key key, this.isPressed, this.text})
      : super(key: key);

  final bool isPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      height: BUTTON_SIZE,
      width: BUTTON_SIZE,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black87, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(offset: isPressed ? Offset(0.0, 1.0) : Offset(0.0, 4.0))
          ]),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
