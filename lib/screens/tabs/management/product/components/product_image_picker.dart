import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/components/image_preview.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';

class ProductImagePicker extends StatefulWidget {
  final Function(List<MultipartFile>) onChanged;
  final List oldImages;
  const ProductImagePicker(
      {Key? key, required this.onChanged, required this.oldImages})
      : super(key: key);

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  List<MyFile> pickedImages = [];
  List<MultipartFile> pickedBlobs = [];
  bool isImageUpdated = false;

  @override
  void initState() {
    // TODO: implement initState
    console.log('product image picker invoked : ', payload: widget.oldImages);
    super.initState();
    // images = widget.netImages!;
    // console.log("images : " + images.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return pickedImages.isEmpty && widget.oldImages.isEmpty
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
                        ...widget.oldImages.mapIndexed((e, i) {
                          console.log("old image : ", payload: e);
                          return Padding(
                            key: ValueKey<String>(
                                i.toString() + isImageUpdated.toString()),
                            padding: const EdgeInsets.only(right: 5),
                            child: ImagePreview(
                              image: e,
                              height: 100,
                              isNetImage: true,
                              onRemoved: () {
                                console.log('image remove', payload: i);
                                _oldImageRemove(i);
                              },
                            ),
                          );
                        }),
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

  _oldImageRemove(int index) {
    widget.oldImages.removeAt(index);
    console.log("widge.oldimage: ", payload: widget.oldImages);
    setState(() {
      isImageUpdated = !isImageUpdated;
    });
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
