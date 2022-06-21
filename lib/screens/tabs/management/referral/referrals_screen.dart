import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("referral".tr),
      ),
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            _controller = webViewController;
            _loadHtmlFromUrl();
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _loadHtmlFromUrl() async {
    var htmlText = await Api.get('auth/tree');
    _controller.loadUrl(Uri.dataFromString(htmlText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
