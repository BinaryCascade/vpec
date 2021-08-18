import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_helper.dart';
import '../../widgets/loading_indicator.dart';
import 'cabinets_map_logic.dart';
import 'cabinets_map_ui.dart';

@immutable
class CabinetsMapScreen extends StatefulWidget {
  const CabinetsMapScreen({Key? key}) : super(key: key);

  @override
  _CabinetsMapScreenState createState() => _CabinetsMapScreenState();
}

class _CabinetsMapScreenState extends State<CabinetsMapScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CabinetsMapLogic>().initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта кабинетов'),
      ),
      body: Consumer<CabinetsMapLogic>(
        builder: (context, storage, child) {
          return storage.nowImageUrl.isEmpty
              ? const LoadingIndicator()
              : Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CabinetsMap(
                      onScaleUpdated: (scale) =>
                          storage.scaleListener(scale),
                    ),
                    FloorChips(),
                  ],
                );
        },
      ),
    );
  }
}
