import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:screenshot/screenshot.dart';

void actionPopup({
  required BuildContext context,
  required dynamic invoice,
  required String type,
  required Future<dynamic> Function(int? id) delete,
  required Future<dynamic> Function(int? id) print
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top : Radius.circular(15)
      )
    ),
    context : context ,
    isScrollControlled: true,
    builder : (BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: ItemDetailCard(invoice : invoice, delete : delete, print : print, type : type)
    )
  );
}

class ItemDetailCard extends StatefulWidget {
  final dynamic invoice;
  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function(int? id) print;
  final String type;

  const ItemDetailCard({
    Key? key, 
    required this.invoice,
    required this.delete, 
    required this.print,
    required this.type,
  }) : super(key: key);

  @override
  State<ItemDetailCard> createState() => _ItemDetailCardState();
}

class _ItemDetailCardState extends State<ItemDetailCard> {
  ScreenshotController screenshotController = ScreenshotController();
    var testing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        titleAndActions(widget.invoice, widget.delete, widget.type),
        Screenshot(
          controller: screenshotController,
          child: Column( children: [
            mb(6),
            invoiceInfo(widget.invoice),
            productLists(context, widget.invoice.products),
            mb(17),
          ]),
        ),
        priceDetail(widget.invoice)
      ],
    );
  }

  Widget titleAndActions(invoice, delete, type) {
    return Column(
      children: [
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row( children: [
              SvgPicture.asset(AppAssets.invoiceIcon,width: 47, height: 47),
              mr(1),
              Text(type == 'sale' ? 'Sale Invoice' : 'Purchase Invoice', style: Styles.h3),
            ]),
            Row( children: [
              InkWell(
                child : SvgPicture.asset(AppAssets.trash,width: 20, height: 20),
                onTap: () => delete(invoice.id),
              ),
            ])
          ]
        ),
        hr(height : 1, mt : 1),
      ],
    );
  }

  Widget invoiceInfo(invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mb(1),
        Text(invoice.invoice_number, style : Styles.h3),
        mb(1.5),
        Row( children: [
          Column( 
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              Text('Invoice Date', style : Styles.label),
              mb(1),
              Text('Due Date', style : Styles.label),
              mb(1),
              Text('From', style : Styles.label),
            ]
          ),
          mr(3),
          Column( 
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              Text(invoice.invoice_date),
              mb(1),
              Text(invoice.due_date),
              mb(1),
              Text(invoice.receiver['shipping_address']??'-'),
            ]
          )
        ]),
        hr(height : 1, mt : 1.5),
      ],
    );
  }

  Widget productLists(context, products) {
    return Expanded(
      child: ListView.builder(
        // shrinkWrap: true,
        itemCount: products.length ,
        itemBuilder: (context, index) {
          var product = products[index];
          return Column(
            children: [
              mb(1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('${product.product_id}'),
                      mr(1),
                      Text('x ${product.quantity}', style: Styles.label),
                    ],
                  ),
                  Text('\$${product.quantity * product.price}'),
                ],
              ),
            ]
          );
        }
      ),
    );
  }

  Widget priceDetail(invoice) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        child: Column(
          children: [
            hr(height: 1, mt : 1, mb : 1),
            Column(
              children: [
                testing != null ?Image.memory(testing) : mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SubTotal', style: Styles.label),
                    Text('\$${invoice.total}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Styles.label),
                    Text('\$${invoice.tax_value}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Styles.textBold),
                    Text('\$${invoice.grand_total}', style: Styles.textBold),
                  ],
                ),
                mb(1.5),
                PrimaryButton(
                  value: 'Print',
                  onPressed: print
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  print() {
    screenshotController.capture(delay: const Duration(milliseconds: 10))
    .then((image) async {
      if (image != null) {
        setState(() {
          testing = image;
          console.log(testing);
        });
      }
    }).catchError((onError) {
      console.log(onError);
    });
  }
}
