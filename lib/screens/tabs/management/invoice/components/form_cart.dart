import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/management/invoice/components/add_product.dart';

class FormCard extends StatefulWidget {
  const FormCard({
    Key? key,
    required this.params,
  }) : super(key: key);

  final Map<String,dynamic> params;

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyTextInput(
            value : widget.params['receiver_name'],
            onChanged: _onValueChanged,
            column: 'receiver_name',
            placeholder: 'Customer Name',
            label : 'Customer Name'
          ),
          MyTextInput(
            value : widget.params['receiver_email'],
            onChanged: _onValueChanged,
            column: 'receiver_email',
            placeholder: 'Email',
            label: 'Email',
          ),
          MyTextInput(
            value : widget.params['receiver_phone'],
            onChanged: _onValueChanged,
            column: 'receiver_phone',
            placeholder: 'Phone Number',
            label: 'Phone Number',
          ),
          MyTextInput(
            value : widget.params['tax_id'],
            onChanged: _onValueChanged,
            column: 'tax_id',
            placeholder: 'Tax Id Number',
            label: 'Tax Id Number',
          ),
          MyTextInput(
            value : widget.params['shipping_address'],
            onChanged: _onValueChanged,
            column: 'shipping_address',
            placeholder: 'Shipping Address',
            label: 'Shipping Address',
            textarea: true,
          ),
          MyTextInput(
            value : widget.params['billing_address'],
            onChanged: _onValueChanged,
            column: 'billing_address',
            placeholder: 'Billing Address',
            label: 'Billing Address',
            textarea: true,
          ),
          hr(height: 1, mt : 1, mb : 1),
          MyTextInput(
            value : widget.params['invoice_number'],
            onChanged: _onValueChanged,
            column: 'invoice_number',
            placeholder: 'Invoice Number',
            label: 'Invoice Number',
          ),
          MyTextInput(
            value : widget.params['ref_number'],
            onChanged: _onValueChanged,
            column: 'ref_number',
            placeholder: 'Reference Number',
            label: 'Reference Number',
          ),
          MyTextInput(
            value : widget.params['account_id'],
            onChanged: _onValueChanged,
            column: 'account_id',
            placeholder: 'Account',
            label: 'Account',
          ),
          mb(1),
          products(context, widget.params['products']),

          priceRow(name : 'Discount', value : 0),
          priceRow(name : 'Tax', value : 0),
          priceRow(name : 'Grand Total', value : 0),
          priceRow(name : 'Paid Amount', value : 0),
          priceRow(name : 'Remain Amount', value : 0),
          hr(height: 1, mt : 0.5),
          priceRow(name : 'Total', value : 0, large : true),
          SecondaryButton(
            value: 'Save as Draft', 
            onPressed: () {}
          ),
          mb(1),
          PrimaryButton(
            value: 'Save',
            onPressed: () {}
          ),
          mb(1),
        ],
      ),
    );
  }

  Widget products(context, products) {
    List<Map<String,dynamic>> data = products;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context,int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product Detail', style: TextStyle(
            color: Color.fromRGBO(0,0,0,0.5),
            fontWeight: FontWeight.bold
          )),
          mb(1),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius : BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[index]['name'], style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )),
                mb(1.5),
                Row(
                  children: const [
                    Expanded(child: Text('Quantity', style: TextStyle(
                      color: Color.fromRGBO(0,0,0,0.5)
                    ))),
                    Expanded(child: Text('Price', style: TextStyle(
                      color: Color.fromRGBO(0,0,0,0.5)
                    ))),
                  ],
                ),
                mb(1),
                Row(
                  children: [
                    Expanded(child: Text("${data[index]['quantity']}", style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ))),
                    Expanded(child: Text("\$${data[index]['price']}", style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ))),
                  ],
                ),
                hr(height: 1, mt : 1.5, mb : 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total', style: TextStyle(
                      color: Color.fromRGBO(0,0,0,0.5),
                      fontWeight: FontWeight.bold
                    )),
                    Text('\$650', style: TextStyle(
                      fontWeight: FontWeight.bold
                    ))
                  ],
                )
              ]
            ),
          ),
          mb(1),
          Center(
            child: PrimaryButton(
              value: 'Add Product',
              width: 170,
              onPressed: () => addProduct(
                context : context, 
                products : data
              ),
            ),
          ),
          mb(1),
        ],
      ),
    );
  }


  Widget priceRow({name , value, bool large = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name', style: TextStyle(
            color: const Color.fromRGBO(0,0,0,0.6),
            fontWeight: large ? FontWeight.bold : FontWeight.normal,
            fontSize: large ? 16 : 14
          )),
          Text('${value == 0 ? "-" : value}', style: TextStyle(
            fontWeight: large ? FontWeight.bold : FontWeight.normal,
            fontSize: large ? 16 : 14
          ),),
        ],
      ),
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      widget.params[column] = value;
    });
  }
}