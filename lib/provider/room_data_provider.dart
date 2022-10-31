import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  Player _player1 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );
  Player _player2 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'O',
  );
  List<String> _displayElement = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int _filledBoxes = 0;

  int get filledBoxes => _filledBoxes;
  List<String> get displayElements => _displayElement;
  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> roomData) {
    _roomData = roomData;

    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElement[index] = choice;
    _filledBoxes++;
    notifyListeners();
  }

  void setFilledBoxValued(int newValue) {
    _filledBoxes = newValue;
    notifyListeners();
  }

  void endGameCleanup() {
    _filledBoxes = 0;

    _player1 = Player(
      nickname: '',
      socketID: '',
      points: 0,
      playerType: 'X',
    );

    _player2 = Player(
      nickname: '',
      socketID: '',
      points: 0,
      playerType: 'O',
    );

    _displayElement = [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ];

    _roomData = {};

    notifyListeners();
  }
}
