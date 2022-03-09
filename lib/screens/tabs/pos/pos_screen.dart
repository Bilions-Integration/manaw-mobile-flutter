import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/pos/category/category_selector.dart';
import 'package:my_app/screens/tabs/pos/components/product_card.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  var selectedImage;

  @override
  void initState() {
    _getFirebaseToken();
    super.initState();
  }

  final auth = Get.find<AuthController>();

  _getFirebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? token = await messaging.getToken();
    print('FCM_TOKEN $token');
  }

  void _showModal() {
    final List<Menu> menuList = [
      Menu(icon: Icons.edit, title: 'Edit', key: 'edit'),
      Menu(icon: Icons.delete, title: 'Delete', key: 'delete'),
      Menu(icon: Icons.copy, title: 'Copy', key: 'copy'),
    ];
    AppWidget.showMenu(
        context: context,
        menuList: menuList,
        onSelect: _onMenuSelect,
        height: 250);
  }

  void _onMenuSelect(data) {
    print(data);
  }

  List products = [
    {'name': "this is long product name and very long"},
    {'name': "short"},
    {'name': "short"},
    {'name': "short"},
    {'name': "this is long product name and very long very very very long"},
    {'name': "this is long product name and very long"},
    {'name': "short"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySelector(context: context),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ProductCard(product: product);
            },
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
        )),
      ],
    );
  }
}
