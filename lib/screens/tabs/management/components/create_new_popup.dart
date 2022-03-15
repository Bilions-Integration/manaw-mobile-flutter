import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class CreateNewPopup {
  CreateNewPopup();

  void open() {
    final context = currentContext();
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        builder: (builder) {
          return Container(
              height: MediaQuery.of(context).size.height - 150,
              padding: MediaQuery.of(context).viewInsets,
              child: MyPopup(context: context));
        });
  }
}

class MyPopup extends StatelessWidget {
  final BuildContext context;
  const MyPopup({
    Key? key,
    required this.context,
  }) : super(key: key);
  static const List<Map> popupItems = [
    {"name": "Product", "icon": AppAssets.icProduct},
    {"name": "Category", "icon": AppAssets.icCategory},
    {"name": "Invoice", "icon": AppAssets.icInvoice},
    {"name": "Discount", "icon": AppAssets.icDiscount},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
        top: 7,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 6,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 25),
            child: Text(
              "Create New",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 260,
            height: 300,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: popupItems.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () => {console.log('New Tapped')},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                                color: AppColors.borderColor, width: 1),
                          ),
                          child: SvgPicture.asset(popupItems[index]["icon"]),
                        ),
                        const SizedBox(
                          width: 1,
                          height: 8,
                        ),
                        Text(popupItems[index]["name"]),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
