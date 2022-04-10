import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';

void actionPopup({
  required BuildContext context,
  required dynamic invoice,
  // required Function(int? id) edit,
  required Future<dynamic> Function(int? id) delete
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
      child: ItemDetailCard(invoice : invoice, delete : delete)
    )
  );
}

class ItemDetailCard extends StatelessWidget {
  final dynamic invoice;
  final Future<dynamic> Function(int? id) delete;

  const ItemDetailCard({
    Key? key, 
    required this.invoice,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          titleAndActions(invoice, delete),
          invoiceInfo(invoice),
          productLists(context, invoice.products),
          priceDetail(invoice)
        ],
      ), 
    );
  }

  Widget titleAndActions(invoice, delete) {
    return Column(
      children: [
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row( children: [
              SvgPicture.asset(AppAssets.invoiceIcon,width: 47, height: 47),
              mr(1),
              const Text('Sale Invoice', style: TextStyle(
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
        mb(1.5),
        hr(height : 1),
      ],
    );
  }

  Widget productLists(context, products) {
    return Column(
      children: [
        SizedBox(
          height: 220,
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
        ),
        // SizedBox(
        //   height: 260,
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Row(
        //               children: [
        //                 const Text('Macbook Pro'),
        //                 mr(1),
        //                 const Text('x2', style: TextStyle(
        //                   color : Color.fromRGBO(0,0,0,0.5)
        //                 )),
        //               ],
        //             ),
        //             const Text('\$650'),
        //           ],
        //         ),
        //         mb(1),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Row(
        //               children: [
        //                 const Text('iphone 13'),
        //                 mr(1),
        //                 const Text('x2', style: TextStyle(
        //                   color : Color.fromRGBO(0,0,0,0.5)
        //                 )),
        //               ],
        //             ),
        //             const Text('\$650'),
        //           ],
        //         ),
        //         mb(1),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Row(
        //               children: [
        //                 const Text('Apple Watch'),
        //                 mr(1),
        //                 const Text('x2', style: TextStyle(
        //                   color : Color.fromRGBO(0,0,0,0.5)
        //                 )),
        //               ],
        //             ),
        //             const Text('\$650'),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
       
        mb(1),
        hr(height: 1),
      ],
    );
  }

  Widget priceDetail(invoice) {
    return Column(
      children: [
        mb(1),
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
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
