import 'package:flutter/material.dart';
import 'package:vpec/utils/routes/routes.dart';

import '/models/document_model.dart';
import '/screens/login/login_logic.dart';
import '/screens/login/login_screen.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран тестирования'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
