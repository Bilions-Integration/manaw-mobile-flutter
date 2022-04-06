import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/image_preview.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/text_tapper.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/management/product/product_option_controller.dart';

class NewPackageModal {
  final Map<String, dynamic>? params;
  NewPackageModal({this.params});

  void open(Function() afterSubmit, int? productId) {
    BuildContext context = currentContext();
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height - 50,
          padding: MediaQuery.of(context).viewInsets,
          child: NewPackageForm(
            afterSubmit: afterSubmit,
            params: params,
            productId: productId,
          ),
        );
      },
    );
  }
}

// List View Widget
class NewPackageForm extends StatefulWidget {
  final Function() afterSubmit;
  final int? productId;
  final Map<String, dynamic>? params;
  const NewPackageForm(
      {Key? key, required this.afterSubmit, this.params, this.productId})
      : super(key: key);

  @override
  State<NewPackageForm> createState() => _NewPackageFormState();
}

class _NewPackageFormState extends State<NewPackageForm> {
  var productOptionController = ProductOptionController();
  Map<String, dynamic> params = {
    "unit": null,
    "coefficient": 1,
    "sale_price": 0,
    "purchase_price": 0,
    "active": true,
  };
  MyFile? image;
  MultipartFile? imgBlob;

  @override
  void initState() {
    if (widget.params != null) {
      setState(() {
        params = widget.params ?? {};
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text((widget.params != null
                                  ? 'Edit Variation'
                                  : 'New Variation')
                              .toUpperCase()),
                          const Spacer(),
                          TextTapper(
                            title: 'CANCEL',
                            onTab: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      mb(2),
                      image != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ImagePreview(
                                  image: image?.path ?? '',
                                  height: 100,
                                  onRemoved: _removeImage),
                            )
                          : params['image'] != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: ImagePreview(
                                      image: params['image'] ?? '',
                                      height: 100,
                                      isNetImage: true,
                                      onRemoved: _removeImage),
                                )
                              : UnitImagePicker(
                                  onChanged: _onImageChanged,
                                ),
                      mb(2),
                      MyTextInput(
                        value: params['unit'],
                        column: 'unit',
                        label: 'Name',
                        placeholder: 'Red Color',
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['coefficient'],
                        column: 'coefficient',
                        label: 'Coefficient',
                        numberOnly: true,
                        placeholder: '0',
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['sale_price'],
                        column: 'sale_price',
                        label: 'Sale Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['purchase_price'],
                        column: 'purchase_price',
                        label: 'Purchase Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: _valueChanged,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PrimaryButton(
                  value: widget.params != null ? 'Update' : 'Create',
                  onPressed: _submit),
            )
          ],
        ),
      ),
    );
  }

  _onImageChanged(MyFile file, MultipartFile blob) {
    setState(() {
      image = file;
      imgBlob = blob;
      params['image'] = blob;
    });
  }

  _removeImage() {
    setState(() {
      image = null;
      imgBlob = null;
      params['image'] = null;
    });
  }

  _valueChanged(val, String? col) {
    setState(() {
      params[col.toString()] = val;
    });
  }

  _submit() async {
    try {
      if (widget.params != null) {
        await productOptionController.updateOption(productOption: params);
      } else {
        await productOptionController.createOption(
            productOption: params, productId: widget.productId!);
      }
      widget.afterSubmit();
      setState(() {
        params = {
          "unit": null,
          "coefficient": 1,
          "sale_price": 0,
          "purchase_price": 0,
        };
      });
      Navigator.pop(context);
    } catch (e) {
      console.warn('Error mutation : ', payload: e.toString());
    }
  }
}

class UnitImagePicker extends StatelessWidget {
  final Function(MyFile file, MultipartFile blob) onChanged;
  const UnitImagePicker({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
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
          'Add Unit Image',
          style: TextStyle(color: AppColors.grey),
        )
      ],
    );
  }

  _showFileUpload({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return null;
    }
    MultipartFile blob =
        await MultipartFile.fromFile(image.path, filename: image.name);
    MyFile file = MyFile(blob: blob, path: image.path, name: image.name);
    onChanged(file, blob);
  }
}
