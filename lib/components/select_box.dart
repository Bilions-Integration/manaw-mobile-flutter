import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class SelectBox extends StatefulWidget {
  final String? placeholder;
  final String? label;
  final String? value;

  final Function() onClick;
  const SelectBox({
    Key? key,
    this.placeholder,
    this.label,
    this.value,
    required this.onClick,
  }) : super(key: key);

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            SizedBox(
              height: 18,
              child: Text(
                widget.label!.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
            ),
          InkWell(
            onTap: widget.onClick,
            child: Container(
              height: 53,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                border: Border.all(color: AppColors.borderColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              child: Row(
                children: [
                  if (widget.placeholder != null && widget.value == null)
                    Text(
                      widget.placeholder ?? '',
                      style: TextStyle(fontSize: 16, color: AppColors.grey),
                    ),
                  if (widget.value != null)
                    Text(
                      widget.value ?? '',
                      style: TextStyle(fontSize: 16, color: AppColors.black),
                    ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
