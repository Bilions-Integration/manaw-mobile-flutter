import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';

viewImages(List images) {
  List<ImageProvider<Object>> imageList = [];
  for (var img in images) {
    imageList.add(Image.network(img).image);
  }
  MultiImageProvider multiImageProvider = MultiImageProvider(imageList);
  showImageViewerPager(currentContext(), multiImageProvider);
}
