import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/resources/socket_methods.dart';
import 'package:tic_tac_toe_game/responsive/responsive.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/custom_button.dart';
import 'package:tic_tac_toe_game/widgets/custom_text.dart';
import 'package:tic_tac_toe_game/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  static const String routeName = "/join-room";

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final nameController = TextEditingController();
  final gameIdController = TextEditingController();
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();

    socketMethods.joinRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
    socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();

    gameIdController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Join room',
                fontSize: 70,
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                hintText: 'Enter your nickname',
                textEditingController: nameController,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                hintText: 'Enter Game ID',
                textEditingController: gameIdController,
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                onTap: () => socketMethods.joinRoom(
                  nameController.text,
                  gameIdController.text,
                ),
                buttonText: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
