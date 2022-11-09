// ignore_for_file: library_prefixes

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io(
      'http://10.10.0.190:3000',
      {
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();

    return _instance!;
  }
}
