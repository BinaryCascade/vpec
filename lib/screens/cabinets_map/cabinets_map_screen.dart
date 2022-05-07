import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/theme_helper.dart';
import '/widgets/loading_indicator.dart';
import 'cabinets_map_logic.dart';
import 'cabinets_map_ui.dart';

class CabinetsMapScreen extends StatelessWidget {
  const CabinetsMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CabinetsMapLogic(),
      child: const CabinetsMapScreenUI(),
    );
  }
}

@immutable
class CabinetsMapScreenUI extends StatefulWidget {
  const CabinetsMapScreenUI({Key? key}) : super(key: key);

  @override
  _CabinetsMapScreenUIState createState() => _CabinetsMapScreenUIState();
}

class _CabinetsMapScreenUIState extends State<CabinetsMapScreenUI> {
  @override
  void initState() {
    super.initState();
    context.read<CabinetsMapLogic>().initializeMap(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: false);

    return Scaffold(
      body: Consumer<CabinetsMapLogic>(
        builder: (context, storage, child) {
          return storage.nowImageUrl.isEmpty
              ? const LoadingIndicator()
              : Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top * 1.5,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CabinetsMap(
                        onScaleUpdated: (scale) => storage.scaleListener(scale),
                      ),
                      FloorChips(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
