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
    builder: (context) => PromptWidget(),
  );
}

class PromptWidget extends StatefulWidget {
  const PromptWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PromptWidget> createState() => _PromptWidgetState();
}

class _PromptWidgetState extends State<PromptWidget> {
  Map<String, dynamic> params = {"password": '', "confirm_password": ''};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        height: 263,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change New Password',
              style: TextStyle(color: AppColors.black, fontSize: 18),
            ),
            mb(2),
            PasswordInput(
              icon: Icons.lock,
              placeholder: 'New Password',
              column: 'password',
              onChanged: _inputChanged,
            ),
            PasswordInput(
              icon: Icons.lock,
              placeholder: 'Confirm',
              column: 'confirm_password',
              onChanged: _inputChanged,
            ),
            mb(1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: Text(('CANCEL').toUpperCase()),
                ),
                mr(3),
                PrimaryButton(
                  value: 'CHANGE',
                  onPressed: () async {
                    try {
                      var res = await ProfileService.changePassword(
                        password: params['password'],
                        confirmPassword: params['confirm_password'],
                      );
                      if (res != false) {
                        Get.snackbar(
                          'Success',
                          'Successfully changed new password!',
                          icon: const Icon(Icons.check_circle),
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      alert(title: 'Error', message: 'Something went wrong. Please try again!.');
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
