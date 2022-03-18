import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime now = DateTime.now();
  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().toString();

  @override
  void initState() {
    setState(() {
      endDate = now.toString();
      startDate = DateTime(now.year, now.month - 1, now.day).toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.dark,
          border: Border(
            top: BorderSide(color: AppColors.white, width: 0.2),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _showCalendar,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(children: [
                SvgPicture.asset(
                  AppAssets.icCalendar,
                  color: AppColors.white,
                ),
                mr(2),
                Text(
                  '${moment(startDate).format()}',
                  style: TextStyle(color: AppColors.white),
                ),
                mr(1),
                Text(
                  '-',
                  style: TextStyle(color: AppColors.white),
                ),
                mr(1),
                Text(
                  '${moment(endDate).format()}',
                  style: TextStyle(color: AppColors.white),
                ),
                const Spacer(),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: SvgPicture.asset(
                    AppAssets.icArrowRight,
                    color: AppColors.white,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _showCalendar() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
      initialDateRange: DateTimeRange(
        start: moment(startDate).parse(),
        end: moment(endDate).parse(),
      ),
      saveText: 'PICK',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(textTheme: GoogleFonts.readexProTextTheme()).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: AppColors.dark,
                ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        startDate = result.start.toString();
        endDate = result.end.toString();
      });
    }
  }
}
