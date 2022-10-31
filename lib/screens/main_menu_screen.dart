import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/responsive/responsive.dart';
import 'package:tic_tac_toe_game/screens/create_room_screen.dart';
import 'package:tic_tac_toe_game/screens/join_room_screen.dart';
import 'package:tic_tac_toe_game/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  static String routeName = "/main-menu";

  void createRoom(BuildContext context) {
    Navigator.pushNamed(
      context,
      CreateRoomScreen.routeName,
    );
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(
      context,
      JoinRoomScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              buttonText: 'Create room',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () => joinRoom(context),
              buttonText: 'Join room',
            ),
          ],
        ),
      ),
    );
  }
}
