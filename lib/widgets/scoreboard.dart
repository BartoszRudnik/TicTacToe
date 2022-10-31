import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/room_data_provider.dart';
import 'package:tic_tac_toe_game/widgets/player_data.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlayerData(
          nickname: roomDataProvider.player1.nickname,
          points: roomDataProvider.player1.points.toInt().toString(),
        ),
        PlayerData(
          nickname: roomDataProvider.player2.nickname,
          points: roomDataProvider.player2.points.toInt().toString(),
        ),
      ],
    );
  }
}
