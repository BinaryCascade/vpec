import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../utils/holiday_helper.dart';
import '../../utils/theme/theme.dart';
import '../../utils/theme_helper.dart';
import '../../widgets/snow_widget.dart';
import '../../widgets/system_bar_cover.dart';
import 'schedule_logic.dart';
import 'schedule_ui.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleLogic(),
      builder: (_, __) => const ScheduleScreenUI(),
    );
  }
}

class ScheduleScreenUI extends StatefulWidget {
  const ScheduleScreenUI({Key? key}) : super(key: key);

  @override
  State<ScheduleScreenUI> createState() => _ScheduleScreenUIState();
}

class _ScheduleScreenUIState extends State<ScheduleScreenUI> {
  @override
  void initState() {
    context.read<ScheduleLogic>().loadSchedule();
    context.read<ScheduleLogic>().startTimersUpdating();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'schedule_screen');
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ScheduleLogic>().cancelTimersUpdating();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleLogic>(
      builder: (context, logic, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: StatusBarCover(
            height: MediaQuery.of(context).padding.top,
          ),
          body: SafeArea(
            top: false,
            child: Stack(
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
                ListView(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 30,
                    right: 30,
                  ),
                  children: [
                    const Text(
                      'Расписание на',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        letterSpacing: 0.15,
                      ),
                    ),
                    // SizedBox(height: 6),
                    InkWell(
                      onTap: () => logic.chooseData(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                logic.printCurrentDate,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const FloatingActionButton(
                            mini: true,
                            onPressed: null,
                            child: Icon(Icons.edit_calendar_outlined),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    logic.fullSchedule == null
                        ? logic.hasError
                            ? ScheduleErrorLoadingUI(errorText: logic.errorText)
                            : Center(
                                child: LinearProgressIndicator(
                                  color: context.palette.highEmphasis,
                                  backgroundColor:
                                      context.palette.backgroundSurface,
                                ),
                              )
                        : Column(
                            children: [
                              SchedulePanel(fullSchedule: logic.fullSchedule!),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: RDottedLineBorder(
                                    // Меняй этой значение, чтобы дэши попали в расстояние нормально
                                    dottedLength: 3.5,
                                    dottedSpace: 3,
                                    left: BorderSide(
                                      width: 3,
                                      color: context.palette.lowEmphasis,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: const [
                                    ChosenGroupBadge(),
                                    SizedBox(height: 130),
                                    // Отступ после расписания, чтобы FAB не перекрывал контент
                                    // Пунктир вместо отступа, чтобы не создавать вид обрыва
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: const FABPanel(),
        );
      },
    );
  }
}
