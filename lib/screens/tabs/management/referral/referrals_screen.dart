import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text("referral".tr),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
      ),
    );
  }

  @override
  void initState() {
    final box = GetStorage();
    final t = box.read('@bearerToken');
    final u = dotenv.env['APP_URL'].toString() +
        '/auth/tree?authorization=Bearer%20' +
        t;
    console.log(u);
    setState(() {
      url = u;
    });
    super.initState();
  }
}
