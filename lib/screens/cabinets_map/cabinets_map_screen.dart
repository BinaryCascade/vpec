import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/theme_helper.dart';
import '/widgets/loading_indicator.dart';
import '../../utils/holiday_helper.dart';
import '../../widgets/snow_widget.dart';
import '../../widgets/system_bar_cover.dart';
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

class CabinetsMapScreenUI extends StatefulWidget {
  const CabinetsMapScreenUI({Key? key}) : super(key: key);

  @override
  State<CabinetsMapScreenUI> createState() => _CabinetsMapScreenUIState();
}

class _CabinetsMapScreenUIState extends State<CabinetsMapScreenUI> {
  @override
  void initState() {
    super.initState();
    context.read<CabinetsMapLogic>().initializeMap(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome(mode: ColoringMode.byCurrentTheme);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StatusBarCover(
        height: MediaQuery.of(context).padding.top,
      ),
      body: Stack(
        children: [
          if (HolidayHelper.isNewYear)
            SnowWidget(
              isRunning: true,
              totalSnow: 20,
              speed: 0.4,
              snowColor: ThemeHelper.isDarkMode
                  ? Colors.white
                  : const Color(0xFFD6D6D6),
            ),
          Consumer<CabinetsMapLogic>(
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 10,
                          ),
                          child: FloorChips(),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
