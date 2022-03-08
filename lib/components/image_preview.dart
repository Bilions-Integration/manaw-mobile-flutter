import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String image;
  final double radius;
  final double height;
  const ImagePreview(
      {Key? key, required this.image, this.radius = 8.0, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(File(image)),
      ),
    );
  }
}
