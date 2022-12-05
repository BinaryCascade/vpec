import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/screens/login/login_logic.dart';
import 'scanner_logic.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final scannerState = ScannerStateNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отсканируйте QR для входа'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: scannerState,
              builder: (context, value, child) {
                // return ScannerWidget();
                return AnimatedCrossFade(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 3000),
                  firstChild: ScannerWidget(),
                  secondChild: NoAccessToCamera(),
                  crossFadeState: value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  // child:
                  //     value ? const ScannerWidget() : const NoAccessToCamera(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text('или', style: Theme.of(context).textTheme.subtitle1),
                OutlinedButton(
                  child: const Text(
                    'Введите данные вручную',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async => await LoginLogic.openLogin(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerWidget extends StatelessWidget {
  const ScannerWidget({
    super.key,
  });

  // formatted as https://example.com/
  static const String domainAddress = 'https://energocollege.web.app/';

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcode, _) {
        if (barcode.type == BarcodeType.url) {
          String url = barcode.url!.url!;
          if (url.startsWith(domainAddress)) {
            Navigator.pushNamed(
              context,
              url.replaceFirst(domainAddress, '/'),
            );
          }
        }
      },
    );
  }
}

class NoAccessToCamera extends StatelessWidget {
  const NoAccessToCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.no_photography_outlined,
          size: 120,
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
        const SizedBox(height: 20),
        Text(
          'Нет доступа к камере',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 22,
              ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            child: const Text('Перейти в настройки'),
            onPressed: () => AppSettings.openAppSettings(asAnotherTask: true),
          ),
        ),
      ],
    );
  }
}
