import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe_game/provider/room_data_provider.dart';
import 'package:tic_tac_toe_game/utils/utils.dart';

class GameMethods {
  void clearBoard(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }

    roomDataProvider.setFilledBoxValued(0);
  }

  void checkWinner(BuildContext context, Socket socketClient) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    if (roomDataProvider.displayElements[0] == roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] == roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[3] == roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] == roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[3] != '') {
      winner = roomDataProvider.displayElements[3];
    }
    if (roomDataProvider.displayElements[6] == roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] == roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[6] != '') {
      winner = roomDataProvider.displayElements[6];
    }

    if (roomDataProvider.displayElements[0] == roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] == roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[1] == roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] == roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }
    if (roomDataProvider.displayElements[2] == roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] == roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }

    if (roomDataProvider.displayElements[0] == roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] == roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[2] == roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] == roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      winner = '';
      showGameDialog(context, 'Draw');
    }

    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialog(context, '${roomDataProvider.player1.nickname} won!');

        if (socketClient.id == roomDataProvider.player1.socketID) {
          socketClient.emit('winner', {
            'winnerSocketId': roomDataProvider.player1.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        }
      } else if (roomDataProvider.player2.playerType == winner) {
        showGameDialog(context, '${roomDataProvider.player2.nickname} won!');

        if (socketClient.id == roomDataProvider.player2.socketID) {
          socketClient.emit('winner', {
            'winnerSocketId': roomDataProvider.player2.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          });
        }
      }
    }
  }
}
