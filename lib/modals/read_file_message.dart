import 'dart:isolate';

class ReadFileMessage {
  final String path;
  final SendPort sendPort;
  ReadFileMessage({required this.path, required this.sendPort});
}
