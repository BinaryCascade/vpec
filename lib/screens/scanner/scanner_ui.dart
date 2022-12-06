import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/screens/login/login_logic.dart';

class ManualLoginPrompt extends StatelessWidget {
  const ManualLoginPrompt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('или', style: Theme.of(context).textTheme.subtitle1),
          OutlinedButton(
            child: const Text(
              'Введите данные вручную',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () => LoginLogic.openLogin(context),
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
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
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
          ),
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.srcOut,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: SizedBox.square(
                    dimension: MediaQuery.of(context).size.shortestSide * 0.6,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox.square(
            dimension: MediaQuery.of(context).size.shortestSide * 0.6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
