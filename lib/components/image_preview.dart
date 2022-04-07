import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class ImagePreview extends StatelessWidget {
  final String image;
  final double radius;
  final double height;
  final bool isNetImage;
  final Function()? onRemoved;
  const ImagePreview({
    Key? key,
    required this.image,
    this.radius = 8.0,
    required this.height,
    this.isNetImage = false,
    this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: isNetImage ? Image.network(image) : Image.file(File(image)),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              onRemoved != null ? onRemoved!() : null;
            },
            child: Icon(
              Icons.remove_circle,
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}
