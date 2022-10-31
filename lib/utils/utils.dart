import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/resources/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  );
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            GameMethods().clearBoard(context);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Play again',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
