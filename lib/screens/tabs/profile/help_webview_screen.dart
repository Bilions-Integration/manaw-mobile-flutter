import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpWebViewScreen extends StatelessWidget {
  const HelpWebViewScreen({
    Key? key,
  }) : super(key: key);

  static const String faqWebUrl =
      'https://manawstore.com/support?platform=mobile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Help'),
        backgroundColor: AppColors.primary,
      ),
      body: const WebView(
        initialUrl: faqWebUrl,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: false,
      ),
    );
  }
}
