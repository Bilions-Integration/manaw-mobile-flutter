import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/assets.dart';

class MyImage {
  static Widget network(String url,
      {double? width, double? height, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => SvgPicture.asset(AppAssets.appLogo),
      errorWidget: (context, url, err) => SvgPicture.asset(AppAssets.icInfo),
      fit: fit,
    );
  }

  static ImageProvider provider(String url) {
    return CachedNetworkImageProvider(url);
  }
}
