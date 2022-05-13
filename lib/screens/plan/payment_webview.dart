import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentStatus extends StatelessWidget {
  final bool isSuccess;
  final String? voucherNo;
  final Function(String) setStatus;
  const PaymentStatus(
      {Key? key,
      required this.setStatus,
      required this.isSuccess,
      this.voucherNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              mb(3),
              SizedBox(
                height: 160,
                child: SvgPicture.asset(
                    isSuccess ? AppAssets.paySuccess : AppAssets.payFail),
              ),
              mb(2),
              Text(
                isSuccess ? 'Payment Successful!' : 'Something went wrong!',
                style: TextStyle(
                  color: isSuccess ? AppColors.green : AppColors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              mb(1),
              SizedBox(
                width: 240,
                child: Text(
                  isSuccess
                      ? 'Your payment was successful! You can now continue using MaNaw Store.'
                      : 'We aren’t able to process your payment. Please try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Styles.t3.fontSize,
                      color: AppColors.grey,
                      height: 1.4),
                ),
              ),
              mb(4),
              if (voucherNo != null)
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 5,
                  children: [
                    const Text('INVOICE NUMBER'),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: voucherNo!));
                        Get.snackbar("Copied", "Invoice number copied",
                            animationDuration:
                                const Duration(milliseconds: 300),
                            duration: const Duration(seconds: 1),
                            backgroundColor: AppColors.white);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.lightGrey,
                            width: 3,
                          ),
                        ),
                        child: Text(voucherNo!),
                      ),
                    )
                  ],
                )
            ],
          ),
          Column(
            children: isSuccess
                ? [
                    PrimaryButton(
                        value: 'Done',
                        onPressed: () {
                          Get.back();
                        })
                  ]
                : [
                    PrimaryButton(
                        value: "Try Again",
                        onPressed: () {
                          setStatus('pending');
                        }),
                    SecondaryButton(
                        value: 'Go Back',
                        onPressed: () {
                          Get.back();
                        })
                  ],
          )
        ],
      ),
    );
  }
}

class PaymentWebView extends StatefulWidget {
  final String webUrl;
  const PaymentWebView({Key? key, required this.webUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentWebViewState();
  }
}

class _PaymentWebViewState extends State<PaymentWebView> {
  String status = 'pending';
  String? voucherNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(status),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Payment'),
        backgroundColor: AppColors.primary,
      ),
      body: status == 'pending'
          ? WebView(
              initialUrl: widget.webUrl,
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              navigationDelegate: (NavigationRequest request) {
                console.log('Navigation made : ', payload: request.url);
                List<String> splittedUrl = request.url.split('/');
                setState(() {
                  if (request.url.contains('fail')) {
                    status = 'fail';
                    voucherNo = splittedUrl.last;
                  } else if (request.url.contains('success')) {
                    status = 'success';
                    voucherNo = splittedUrl.last;
                  }
                });
                return NavigationDecision.navigate;
              },
            )
          : PaymentStatus(
              isSuccess: status == 'success',
              voucherNo: voucherNo,
              setStatus: _setStatus),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _setStatus(String s) {
    setState(() {
      status = s;
    });
  }
}
