import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/models/document_model.dart';
import '/screens/login/login_logic.dart';
import '/screens/login/login_screen.dart';
import '../../utils/notifications/firebase_messaging.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/loading_indicator.dart';
import '../schedule/schedule_screen.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран тестирования'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: AppFirebaseMessaging.getToken(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoadingIndicator();

                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Clipboard.setData(
                          ClipboardData(text: snapshot.data!),
                        ),
                        child: const Text('Copy FCM token'),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                ),
                child: const Text('LoginScreen'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ScheduleScreen(),
                  ),
                ),
                child: const Text('ScheduleScreen'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  String docURL = await LoginLogic.getEntrantUrl();
                  Navigator.pushNamed(
                    context,
                    '/view_document',
                    arguments: DocumentModel(
                      title: 'Для абитуриента',
                      subtitle: '',
                      url: docURL,
                    ),
                  );
                },
                child: const Text('EntrantScreen'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async => Navigator.pushNamed(
                  context,
                  Routes.jobQuizScreen,
                ),
                child: const Text('JobQuiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
