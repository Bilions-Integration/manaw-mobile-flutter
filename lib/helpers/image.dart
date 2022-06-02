import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class MyImage {
  static Widget network(String url,
      {double? width, double? height, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => Center(
        child: SvgPicture.asset(
          AppAssets.manage,
          color: AppColors.lightPurple,
        ),
      ),
      fit: fit,
    );
  }

  static ImageProvider provider(String url) {
    return CachedNetworkImageProvider(url);
  }
}
