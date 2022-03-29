import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/components/image_preview.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';

class ProductImagePicker extends StatefulWidget {
  final Function(List<MultipartFile>) onChanged;
  final List<dynamic>? netImages;
  const ProductImagePicker({Key? key, required this.onChanged, this.netImages})
      : super(key: key);

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  List<MyFile> pickedImages = [];
  List<MultipartFile> pickedBlobs = [];
  List<dynamic> images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.netImages!;
    console.log("images : " + images.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return pickedImages.isEmpty
        ? Column(
            children: [
              InkWell(
                onTap: _showFileUpload,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.add_rounded),
                ),
              ),
              mb(1),
              Text(
                'Add Product Image',
                style: TextStyle(color: AppColors.grey),
              )
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: _showFileUpload,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.add_rounded),
                          ),
                        ),
                        ...pickedImages
                            .mapIndexed(
                              (MyFile e, index) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: ImagePreview(
                                  image: e.path,
                                  height: 100,
                                  onRemoved: () {
                                    _imageRemoved(index);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    )
                  ],
                ),
              ),
              mb(1),
              Text(
                'Add Product Image',
                style: TextStyle(color: AppColors.grey),
              ),
            ],
          );
  }

  _imageRemoved(index) {
    List<MyFile> files = pickedImages;
    files.removeAt(index);
    List<MultipartFile> blobs = pickedBlobs;
    blobs.removeAt(index);

    setState(() {
      pickedImages = files;
      pickedBlobs = blobs;
      files.forEach((element) {
        console.log('Files: ');
        console.log(element.toString());
      });
      blobs.forEach((element) {
        console.log('Blob: ');
        console.log(element.length);
      });
    });

    widget.onChanged(blobs);
  }

  _showFileUpload({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images == null) {
      return null;
    }
    List<MyFile> files = [...pickedImages];
    List<MultipartFile> blobs = [...pickedBlobs];

    for (var image in images) {
      final blob =
          await MultipartFile.fromFile(image.path, filename: image.name);
      files = [
        MyFile(blob: blob, path: image.path, name: image.name),
        ...files
      ];
      blobs = [blob, ...blobs];
    }

    setState(() {
      pickedImages = files;
      pickedBlobs = blobs;
    });

    widget.onChanged(blobs);
  }
}
