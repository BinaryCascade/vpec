import 'package:mobile_scanner/mobile_scanner.dart';

class MyMobileScannerController extends MobileScannerController {
  Future<bool> get isDenied async {
    if (isStarting) {
      MobileScannerState state = MobileScannerState
          .values[await methodChannel.invokeMethod('state') as int];

      return state == MobileScannerState.denied;
    }

    return true;
  }
}
