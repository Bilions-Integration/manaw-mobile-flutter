import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';
import 'package:my_app/screens/tabs/dashboard/dashboard_controller.dart';

class DatePicker extends StatefulWidget {
  final Function(String, String) onDateChanged;

  const DatePicker({Key? key, required this.onDateChanged}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final dashboardController = Get.find<DashboardController>();

  DateTime now = DateTime.now();
  String startDate = moment.string(DateTime.now());
  String endDate = moment.string(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
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

  @override
  void initState() {
    setState(() {
      endDate = moment.string(now);
      startDate = moment.string(DateTime(now.year, now.month - 1, now.day));
    });
    dashboardController.startDate.value = startDate;
    dashboardController.endDate.value = endDate;
    super.initState();
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
                  primary: AppColors.primary,
                ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        startDate = moment.string(result.start);
        endDate = moment.string(result.end);
      });
      dashboardController.startDate.value = startDate;
      dashboardController.endDate.value = endDate;

      widget.onDateChanged(startDate, endDate);
    }
  }
}
