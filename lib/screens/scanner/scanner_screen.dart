import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/screens/login/login_logic.dart';
import 'scanner_logic.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  // formatted as https://example.com/
  final String domainAddress = 'https://energocollege.web.app/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отсканируйте QR для входа'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<bool>(
              future: MyMobileScannerController().isDenied,
              initialData: true,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (!snapshot.data!) {
                    return MobileScanner(
                      controller: MyMobileScannerController(),
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

                return const Text('youre duuumb');
              },
            ),
            // child: !MyMobileScannerController().isDenied
            //     ? MobileScanner(
            //         controller: MyMobileScannerController(),
            //         onDetect: (barcode, _) {
            //           if (barcode.type == BarcodeType.url) {
            //             String url = barcode.url!.url!;
            //             if (url.startsWith(domainAddress)) {
            //               Navigator.pushNamed(
            //                 context,
            //                 url.replaceFirst(domainAddress, '/'),
            //               );
            //             }
            //           }
            //         },
            //       )
            //     : const Text('youre dumb'),
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
