import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/models/document_model.dart';
import '/screens/view_document/view_document_logic.dart';
import '/utils/utils.dart';
import '../utils/theme/theme.dart';

/// Create markdown with branded colors and text style
class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({
    Key? key,
    required this.data,
    this.shrinkWrap = false,
    this.onTapLink,
  }) : super(key: key);

  /// MD data to display, example:
  ///
  /// `# Hello World`
  final String data;

  final bool shrinkWrap;

  /// `String text, String? href,  String title`
  ///
  /// Called when user click on link
  final void Function(String, String?, String)? onTapLink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Markdown(
        shrinkWrap: shrinkWrap,
        selectable: true,
        data: data,
        onTapLink: onTapLink ??
            (text, href, title) {
              if (href != null) {
                if (ViewDocumentLogic.isThisURLSupported(href)) {
                  Navigator.pushNamed(
                    context,
                    '/view_document',
                    arguments: DocumentModel(
                      title: text,
                      subtitle: '',
                      url: href,
                    ),
                  );
                } else {
                  openUrl(href);
                }
              }
            },
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 48,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
          ),
          h2: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 38,
            fontWeight: FontWeight.w400,
          ),
          h3: TextStyle(
            color: context.palette.highEmphasis,
            fontFamily: 'Montserrat',
            fontSize: 32,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          h4: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          h5: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          h6: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          p: TextStyle(
            color: context.palette.highEmphasis,
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
