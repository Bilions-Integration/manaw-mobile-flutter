import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';

void addProduct({
  required BuildContext context,
  required List<Map<String,dynamic>> products,
  // required dynamic invoice,
  // required Function(int? id) edit,
  // required Future<dynamic> Function(int? id) delete
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
      child: const ProductForm()
    )
  );
}

class ProductForm extends StatefulWidget {
  const ProductForm({
    Key? key,
    // required this.products
  }) : super(key: key);

  // final List<Map<String,dynamic>> products;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final Map<String,dynamic> product = {
    'name' : '',
    'quantity' : '',
    'price' : '',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          MyTextInput(
            value : product['name'],
            onChanged: (value, column) => _onValueChanged(value,column),
            column: 'name',
            placeholder: 'Product Name',
            label : 'Product Name'
          ),
          MyTextInput(
            value : product['quantity'],
            onChanged: (value, column) => _onValueChanged(value,column),
            column: 'quantity',
            placeholder: 'Quantity',
            label : 'Quantity',
            numberOnly: true,
          ),
          MyTextInput(
            value : product['price'],
            onChanged: (value, column) => _onValueChanged(value,column),
            column: 'price',
            placeholder: 'Price',
            label : 'Price',
            numberOnly: true,
          ),
          PrimaryButton(
            value : 'Add',
            onPressed: () => addProduct(),
          ),
          Text(totalPrice(product)),
        ],
      ),
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      product[column] = value;
    });
  }

  totalPrice(product) {
    int quantity = product['quantity'] != '' ? int.parse(product['quantity'].toString()) : 0;
    int price = product['price'] != '' ? int.parse(product['price'].toString()) : 0;
    return (quantity * price) != 0 ? (quantity * price).toString() : '';
  }

  addProduct() {
    // setState(() {
    //   widget.products.add(product);
    // });
  }

}