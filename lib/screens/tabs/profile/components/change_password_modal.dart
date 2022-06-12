import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/services/profile_service.dart';

changePassword() {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const ChangePasswordModalWidget(),
  );
}

class ChangePasswordModalWidget extends StatefulWidget {
  const ChangePasswordModalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordModalWidget> createState() =>
      _ChangePasswordModalWidgetState();
}

class _ChangePasswordModalWidgetState extends State<ChangePasswordModalWidget> {
  Map<String, dynamic> params = {"password": '', "confirm_password": ''};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'changePassword'.tr,
              style: TextStyle(color: AppColors.black, fontSize: 18),
            ),
            mb(2),
            PasswordInput(
              icon: Icons.lock,
              placeholder: 'newPassword'.tr,
              column: 'password',
              onChanged: _inputChanged,
            ),
            PasswordInput(
              icon: Icons.lock,
              placeholder: 'confirmPassword'.tr,
              column: 'confirm_password',
              onChanged: _inputChanged,
            ),
            mb(1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: Text(('cancel'.tr).toUpperCase()),
                ),
                mr(3),
                PrimaryButton(
                  value: 'change'.tr,
                  onPressed: () async {
                    try {
                      var res = await ProfileService.changePassword(
                        password: params['password'],
                        confirmPassword: params['confirm_password'],
                      );
                      if (res != false) {
                        snackBar(
                          'success'.tr,
                          'successPassword'.tr,
                          icon: Icons.check_circle,
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      alert(title: 'failed'.tr, message: 'failPassword'.tr);
                    }
                  },
                  width: 100,
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _inputChanged(String? data, String? column) {
    setState(() {
      params[column!] = data;
    });
  }
}
