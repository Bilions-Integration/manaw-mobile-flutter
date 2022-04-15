import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';


import 'helper.dart';

class Styles {
  static topOnlyBorderRadius(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }



  //Normal text is same with t5
  static TextStyle h1 = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle h2 = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle h3 = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle h4 = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle h5 = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle h6 = const TextStyle(fontSize: 13, fontWeight: FontWeight.bold);

  static TextStyle h1Light = TextStyle(color : AppColors.white, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle h2Light = TextStyle(color : AppColors.white, fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle h3Light = TextStyle(color : AppColors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle h4Light = TextStyle(color : AppColors.white, fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle h5Light = TextStyle(color : AppColors.white, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle h6Light = TextStyle(color : AppColors.white, fontSize: 13, fontWeight: FontWeight.bold);

  static TextStyle t1 = const TextStyle(fontSize: 18);
  static TextStyle t2 = const TextStyle(fontSize: 17);
  static TextStyle t3 = const TextStyle(fontSize: 16);
  static TextStyle t4 = const TextStyle(fontSize: 15);
  static TextStyle t5 = const TextStyle(fontSize: 14);
  static TextStyle t6 = const TextStyle(fontSize: 13);

  static TextStyle t1Light = TextStyle(color : AppColors.white, fontSize: 18);
  static TextStyle t2Light = TextStyle(color : AppColors.white, fontSize: 17);
  static TextStyle t3Light = TextStyle(color : AppColors.white, fontSize: 16);
  static TextStyle t4Light = TextStyle(color : AppColors.white, fontSize: 15);
  static TextStyle t5Light = TextStyle(color : AppColors.white, fontSize: 14);
  static TextStyle t6Light = TextStyle(color : AppColors.white, fontSize: 13);

  static TextStyle l1 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 18);
  static TextStyle l2 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 17);
  static TextStyle l3 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 16);
  static TextStyle l4 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 15);
  static TextStyle l5 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 14);
  static TextStyle l6 = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontSize: 13);

  static TextStyle label = const TextStyle(color: Color.fromRGBO(0,0,0,0.5));
  static TextStyle labelBold = const TextStyle(color: Color.fromRGBO(0,0,0,0.5), fontWeight: FontWeight.bold);

  static TextStyle textBold = const TextStyle(fontWeight: FontWeight.bold);

  static TextStyle normalText = const TextStyle(fontSize: 14);






  static Widget loading = Center(
    child: RefreshProgressIndicator(
      color : AppColors.dark,
    )
  );

  static Widget emptyList(label, image, buttonLabel, link) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          Text(label),
          mb(1.5),
          SecondaryButton(
            value: buttonLabel,
            width: 220,
            onPressed: () => Get.to(link),
          )
        ],
      ),
    );
  }

  static void customBottomSheet(BuildContext context, num height,Widget widget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top : Radius.circular(20)
        )
      ),
      isScrollControlled : true,
      context: context, 
      builder: (BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * ( height / 100 ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
            top: 7,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 6,
                width: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              mb(1),
              Expanded(
                child : SizedBox(
                  width: double.infinity,
                  child: widget,
                )
              )
            ]
          )
        )
      )
    );
  }
}
