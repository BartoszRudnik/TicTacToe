import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe_game/provider/room_data_provider.dart';
import 'package:tic_tac_toe_game/resources/game_methods.dart';
import 'package:tic_tac_toe_game/resources/socket_client.dart';
import 'package:tic_tac_toe_game/screens/game_screen.dart';
import 'package:tic_tac_toe_game/screens/main_menu_screen.dart';
import 'package:tic_tac_toe_game/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit(
        'tap',
        {
          'index': index,
          'roomId': roomId,
        },
      );
    }
  }

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit(
        'createRoom',
        {
          'nickname': nickname,
        },
      );
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit(
        'joinRoom',
        {
          'nickname': nickname,
          'roomId': roomId,
        },
      );
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'createRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);

        Navigator.pushNamed(
          context,
          GameScreen.routeName,
        );
      },
    );
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'joinRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);

        Navigator.pushNamed(
          context,
          GameScreen.routeName,
        );
      },
    );
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on(
      'errorOccurred',
      (data) => showSnackBar(context, data),
    );
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on(
      'updatePlayers',
      (playersData) {
        final roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

        roomDataProvider.updatePlayer1(playersData[0]);
        roomDataProvider.updatePlayer2(playersData[1]);
      },
    );
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on(
      'updateRoom',
      (data) {
        Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(data);
      },
    );
  }

  void tappedListener(BuildContext context) {
    _socketClient.on(
      'tapped',
      (data) {
        final roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

        roomDataProvider.updateDisplayElements(
          data['index'],
          data['choice'],
        );

        roomDataProvider.updateRoomData(
          data['room'],
        );

        GameMethods().checkWinner(
          context,
          socketClient,
        );
      },
    );
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on(
      'pointIncrease',
      (playerData) {
        final roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

        if (playerData['socketID'] == roomDataProvider.player1.socketID) {
          roomDataProvider.updatePlayer1(playerData);
        } else {
          roomDataProvider.updatePlayer2(playerData);
        }
      },
    );
  }

  void endGameListener(BuildContext context) {
    _socketClient.on(
      'endGame',
      (playerData) {
        showGameDialog(
          context,
          '${playerData['nickname']} won the game!',
        );

        Provider.of<RoomDataProvider>(context, listen: false).endGameCleanup();

        Navigator.popUntil(
          context,
          ModalRoute.withName(
            MainMenuScreen.routeName,
          ),
        );
      },
    );
  }
}
