import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class CloneModal extends StatefulWidget {
  const CloneModal({
    Key? key,
    required this.submit
  }) : super(key: key);

  final Function(bool val) submit;

  @override
  State<CloneModal> createState() => _CloneModalState();
}

class _CloneModalState extends State<CloneModal> {
  bool cloneUnit = true;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
        child: Column(
          children: [
            const Text('Would you like to clone variation?', style: TextStyle(
              fontWeight:  FontWeight.bold
            )),
            mb(0.5),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Checkbox(
                    value: cloneUnit, 
                    fillColor: MaterialStateProperty.all(AppColors.primary),
                    shape : const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                        cloneUnit = !cloneUnit;
                      });
                    }
                  ),
                ),
                mr(1),
                const Text('yes, clone please')
              ],
            ),
            mb(1),
            PrimaryButton(
              value: 'Done',
              onPressed: () {
                widget.submit(cloneUnit);
                Navigator.pop(context);
              },
              width: 100,
              height: 40,
            )
          ],
        ),
      ),
    );
  }

}