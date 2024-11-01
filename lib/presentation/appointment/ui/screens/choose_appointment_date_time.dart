import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/presentation/common/tag.dart';

class ChooseAppointmentDateTimeScreen extends StatefulWidget {
  const ChooseAppointmentDateTimeScreen({super.key});

  @override
  _ChooseAppointmentDateTimeScreenState createState() =>
      _ChooseAppointmentDateTimeScreenState();
}

class _ChooseAppointmentDateTimeScreenState
    extends State<ChooseAppointmentDateTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Text(
            "Booking Appointment",
            style: TextStyle(
                color: ColorManager.textBlockColorLight,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Step 3/5",
            style: TextStyle(
                color: ColorManager.highlightColorLight, fontSize: 13.sp),
          ),
          30.verticalSpace,
          Text(
            'Select Schedule',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          12.verticalSpace,
          SizedBox(
            height: 70.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _buildDayButton('Mon', '7'),
                _buildDayButton('Tue', '8'),
                _buildDayButton('Wed', '10'),
                _buildDayButton('Thu', '11', selected: true),
                _buildDayButton('Fri', '12'),
                _buildDayButton('Sat', '13'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Morning',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                direction: Axis.horizontal,
                spacing: 10.w,
                runSpacing: 10.w,
                children: [
                  TagChip(
                    text: '7:00 AM',
                  ),
                  TagChip(
                    text: '8:00 AM',
                    isSelected: true,
                  ),
                  TagChip(
                    text: '9:00 AM',
                  ),
                  TagChip(
                    text: '10:00 AM',
                  ),
                  TagChip(
                    text: '11:00 AM',
                    active: false,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Afternoon',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                direction: Axis.horizontal,
                spacing: 10.w,
                runSpacing: 10.w,
                children: [
                  TagChip(
                    text: '7:00 AM',
                  ),
                  TagChip(
                    text: '8:00 AM',
                    isSelected: true,
                  ),
                  TagChip(
                    text: '9:00 AM',
                  ),
                  TagChip(
                    text: '10:00 AM',
                  ),
                  TagChip(
                    text: '11:00 AM',
                    active: false,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildDayButton(String day, String time, {bool selected = false}) {
    return Container(
        margin: EdgeInsets.only(left: 10.w),
        child: TagChip(
          text: '$day\n$time',
          height: 50.h,
          width: 40.w,
          isSelected: selected,
        ));
  }

  Widget _buildTimeButton(String time) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        overlayColor: Colors.white,
      ),
      child: Text(time),
    );
  }
}
