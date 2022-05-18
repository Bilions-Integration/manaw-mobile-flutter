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
          title: Text('Choose Payment Method'),
          backgroundColor: AppColors.primary,
        ),
        body: loading
            ? LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ...paymentMethods.map((e) => methodCard(e)),
                  ],
                ),
              ));
  }

  Widget methodCard(PaymentMethod method) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          method.images.length > 1
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.label,
                      style: Styles.h4,
                    ),
                    Row(
                      children: [
                        ...method.images.map(
                          (e) => Row(
                            children: [
                              Container(
                                width: 23,
                                height: 23,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.network(
                                  e,
                                ),
                              ),
                              mr(0.5),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Row(
                  children: [
                    Container(
                        width: 45,
                        height: 45,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          method.images.first,
                          fit: BoxFit.cover,
                        )),
                    mr(1),
                    Text(
                      method.label,
                      style: Styles.h4,
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
