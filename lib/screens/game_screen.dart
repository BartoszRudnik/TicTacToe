import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/room_data_provider.dart';
import 'package:tic_tac_toe_game/resources/socket_methods.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/scoreboard.dart';
import 'package:tic_tac_toe_game/widgets/tic_tac_toe_board.dart';
import 'package:tic_tac_toe_game/widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static String routeName = "/game-screen";

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();

    socketMethods.updateRoomListener(context);
    socketMethods.updatePlayersStateListener(context);
    socketMethods.pointIncreaseListener(context);
    socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                    "${roomDataProvider.roomData['turn']['nickname']}'s turn",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
