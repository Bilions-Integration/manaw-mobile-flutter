import 'package:flutter/cupertino.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          Text('iPhone'),
          Text("500"),
        ],
      ),
    );
  }
}
