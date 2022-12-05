import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerStateNotifier extends ValueNotifier<bool> {
  ScannerStateNotifier(bool value) : super(value) {
    startListeningToUpdates();
  }

  final MobileScannerController _controller = MobileScannerController();

  MobileScannerController get getController => _controller;

  MethodChannel get getChannel => _controller.methodChannel;

  void startListeningToUpdates() {
    Timer.periodic(const Duration(milliseconds: 300), (timer) async {
      value = await isAuthorized;

      if (value) {
        notifyListeners();
        timer.cancel();
      }
    });
  }

  Future<bool> get isAuthorized async {
    var state = MobileScannerState
        .values[await getChannel.invokeMethod('state') as int];

    // if (state == MobileScannerState.undetermined) {

    //   print('AADJSDJKSDHKJASHKDJHAKS result');
    // }

    // print('!!!!!!!!!! $state');

    return state == MobileScannerState.authorized;
  }
}
