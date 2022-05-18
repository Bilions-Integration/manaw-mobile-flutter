import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
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
  late PaymentMethod selectedMethod;

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
      body: paymentMethods.isEmpty
          ? LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Methods",
                    style: Styles.l5,
                  ),
                  mb(1),
                  Expanded(
                    child: ListView(
                      children: [
                        ...paymentMethods.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: methodCard(e),
                            )),
                      ],
                    ),
                  ),
                  PrimaryButton(value: "Pay Now", onPressed: () {}),
                ],
              ),
            ),
    );
  }

  Widget multiplePayment(PaymentMethod method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          method.label,
          style: Styles.h4,
        ),
        mb(0.3),
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
    );
  }

  Widget singlePayment(PaymentMethod method) {
    return Row(
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
        mr(1.3),
        Text(
          method.label,
          style: Styles.h4,
        )
      ],
    );
  }

  Widget methodCard(PaymentMethod method) {
    return InkWell(
      onTap: () => _select(method),
      child: Container(
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, right: 15, left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            method.images.length > 1
                ? multiplePayment(method)
                : singlePayment(method),
            _isSelected(method)
                ? Icon(
                    Icons.radio_button_on,
                    color: AppColors.primary,
                  )
                : Icon(
                    Icons.radio_button_off,
                    color: AppColors.line,
                  ),
          ],
        ),
      ),
    );
  }

  bool _isSelected(PaymentMethod method) {
    return method.key == selectedMethod.key;
  }

  _select(PaymentMethod method) {
    setState(() {
      selectedMethod = method;
    });
  }

  _getPaymentMethods() async {
    var methods = await paymentController.getMethods();
    setState(() {
      paymentMethods = methods;
      selectedMethod = paymentMethods.firstWhere((element) => element.selected);
    });
  }
}
