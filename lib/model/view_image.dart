import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/model/unit_model.dart';

viewImages({required Product product, Unit? selectedUnit}) {
  List images = [];
  if (selectedUnit != null && selectedUnit.image != null) {
    images = [selectedUnit.image];
  } else {
    images = product.images;
  }
  List<ImageProvider<Object>> imageList = [];
  for (var img in images) {
    imageList.add(Image.network(img).image);
  }
  MultiImageProvider multiImageProvider = MultiImageProvider(imageList);
  showImageViewerPager(currentContext(), multiImageProvider);
}
