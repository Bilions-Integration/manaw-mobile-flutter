import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

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

class ItemDetailCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      color : AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column( children: [
            titleAndActions(invoice, delete, type),
            invoiceInfo(invoice),
            productLists(context, invoice.products),
          ],),
          priceDetail(invoice)
        ],
      ), 
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
              Text(type == 'sale' ? 'Sale Invoice' : 'Purchase Invoice', style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )),
            ]),
            Row( children: [
              InkWell(
                child: SvgPicture.asset(AppAssets.edit,width: 20, height: 20),
                onTap: () {},
              ),
              mr(1),
              InkWell(
                child : SvgPicture.asset(AppAssets.clone,width: 20, height: 20),
                onTap: () {},
              ),
              mr(1),
              InkWell(
                child : SvgPicture.asset(AppAssets.trash,width: 20, height: 20),
                onTap: () => delete(invoice.id),
              ),
            ])
          ]
        ),
        mb(1),
        hr(height : 1),
      ],
    );
  }

  Widget invoiceInfo(invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mb(1),
        Text(invoice.invoice_number, style : const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        mb(1.5),
        Row( children: [
          Column( 
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              const Text('Invoice Date', style : TextStyle(
                color : Color.fromRGBO(0,0,0,0.5)
              )),
              mb(1),
              const Text('Due Date', style : TextStyle(
                color : Color.fromRGBO(0,0,0,0.5)
              )),
              mb(1),
              const Text('From', style : TextStyle(
                color : Color.fromRGBO(0,0,0,0.5)
              )),
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
                      Text('${product.id}'),
                      mr(1),
                      Text('x ${product.quantity}', style: const TextStyle(
                        color : Color.fromRGBO(0,0,0,0.5)
                      )),
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
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            hr(height: 1, mt : 1, mb : 1),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SubTotal', style: TextStyle(
                      color : Color.fromRGBO(0,0,0,0.5)
                    )),
                    Text('\$${invoice.total}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tax', style: TextStyle(
                      color : Color.fromRGBO(0,0,0,0.5)
                    )),
                    Text('\$${invoice.tax_value}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    Text('\$${invoice.grand_total}', style: const TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                mb(1.5),
                PrimaryButton(
                  value: 'Print',
                  onPressed: () => print(invoice.id),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
