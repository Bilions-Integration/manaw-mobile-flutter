import 'package:flutter/material.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/upgrade_plan.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['a', 'asdf', 'sbdre'];
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CurrentPlan(),
          Column(
            children: <Widget>[for (var item in items) Text(item)],
          ),
          const UpgradePlan(),
        ],
      ),
    ));
  }
}
