import 'dart:html';

void main() async {
  var webSocket = new WebSocket('wss://relay.dev.grid.tf');
  if (webSocket != null && webSocket.readyState == WebSocket.OPEN) {
    webSocket.send("");
  } else {
    print('WebSocket not connected ');
  }

  // var socket = await WebSocket.connect('wss://relay.dev.grid.tf');

  // socket.listen((data) {
  //   print('$data');
  // });

  // await socket.close();
}
