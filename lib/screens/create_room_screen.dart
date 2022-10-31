import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/resources/socket_methods.dart';
import 'package:tic_tac_toe_game/responsive/responsive.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/custom_button.dart';
import 'package:tic_tac_toe_game/widgets/custom_text.dart';
import 'package:tic_tac_toe_game/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  static String routeName = "/create-room";

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final textEditingController = TextEditingController();
  final socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();

    socketMethods.createRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.dispose();
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
                text: 'Create room',
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
                textEditingController: textEditingController,
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                onTap: () => socketMethods.createRoom(
                  textEditingController.text,
                ),
                buttonText: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
