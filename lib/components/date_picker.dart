import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';

class DatePicker extends StatefulWidget {
  final Function(String, String) onDateChanged;
  final String startDate;
  final String endDate;

  const DatePicker({
    Key? key, 
    required this.startDate, 
    required this.endDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

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
                  '${moment(widget.startDate).format()}',
                  style: TextStyle(color: AppColors.white),
                ),
                mr(1),
                Text(
                  '-',
                  style: TextStyle(color: AppColors.white),
                ),
                mr(1),
                Text(
                  '${moment(widget.endDate).format()}',
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
        start: moment(widget.startDate).parse(),
        end: moment(widget.endDate).parse(),
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
      widget.onDateChanged(moment.string(result.start), moment.string(result.end));
    }
  }
}
