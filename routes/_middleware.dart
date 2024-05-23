// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return handler.use(requestLogger()).use(provider<String>((context) => 'Welcome Shafi to the ocean of backend'));
}
