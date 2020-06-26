import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class NotificationRepo{
  

  static createSocket(){
    // Dart client
    IO.Socket socket = IO.io('http://localhost:3000/api/employees');


    /* socket.on('connect', (_) {
     print('connect ............ ******* Socket *******');
     socket.emit('msg', 'test');
    }); */

    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    print('Creation du socket');

    }

}