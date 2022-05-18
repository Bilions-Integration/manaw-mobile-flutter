import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/payment_method_model.dart';
import 'package:my_app/screens/plan/payment_service.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodScreenState();
  }
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List<PaymentMethod> paymentMethods = [];
  var paymentController = Get.find<PaymentController>();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment Method'),
          backgroundColor: AppColors.primary,
        ),
        body: loading
            ? LoadingWidget()
            : Column(
                children: [
                  Text("Choose payment methods"),
                  ...paymentMethods.map((e) => methodCard(e)),
                ],
              ));
  }

  Widget methodCard(PaymentMethod method) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          method.images.length > 1
              ? Column(
                  children: [
                    Text(
                      method.label,
                      style: Styles.h6,
                    ),
                    Row(
                      children: [
                        ...method.images.map(
                          (e) => Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.network(
                              e,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Row(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Image.network(
                          method.images.isNotEmpty
                              ? method.images.first
                              : AppAssets.placeholder,
                          fit: BoxFit.cover,
                        )),
                    mr(1),
                    Text(
                      method.label,
                      style: Styles.h5,
                    )
                  ],
                ),
          Icon(Icons.radio_button_off),
        ],
      ),
    );
  }

  _getPaymentMethods() async {
    var methods = await paymentController.getMethods();
    setState(() {
      paymentMethods = methods;
      loading = false;
    });
  }
}
