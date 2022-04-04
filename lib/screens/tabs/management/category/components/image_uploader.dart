import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:dio/dio.dart';

class ImageUploader extends StatefulWidget {
  final Map? params;

  const ImageUploader({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final bool isGallery = true;
  final bool cropImage = true;
  File? currentlyPickedImage;

  Future pickMedia() async {
    final ImageSource source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;
    if (!cropImage) {
      setImage(File(pickedFile.path));
    } else {
      cropSquareImage(pickedFile);
    }
  }

  Future cropSquareImage(XFile pickedFile) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg
    );

    if(croppedFile != null) setImage(croppedFile);
  }

  Future setImage(File fileToSave) async {
    currentlyPickedImage = fileToSave;
    String fileName = fileToSave.path.split('/').last;
    MultipartFile image = await MultipartFile.fromFile(fileToSave.path,filename: fileName);
    setState(() => widget.params?['image'] = image);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pickMedia();
            },
            child : Container(
              width : MediaQuery.of(context).size.width * 0.4,
              height : MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xffE8E8E8),
                borderRadius: BorderRadius.circular(20),
              ),
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child : currentlyPickedImage != null 
                      ? Image.file(currentlyPickedImage!)
                      : widget.params?['old_image'] != null
                      ? Image.network(widget.params?['old_image'])
                      : SvgPicture.asset(AppAssets.plus,width: 20, height: 20)
                  ),
                ],
              ),
            )
          ),
          const SizedBox(height: 10),
          const Text('add Category Image', style: TextStyle(fontSize: 15)),
      ],
    ));
  }
}
