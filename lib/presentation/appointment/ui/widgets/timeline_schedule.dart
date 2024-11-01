import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/main.dart';

class TimelineSchedule extends StatelessWidget {
  const TimelineSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 24,
      itemBuilder: (context, index) {
        return TimelineItem(hour: index);
      },
    );
  }
}

class TimelineItem extends StatelessWidget {
  final int hour;

  const TimelineItem({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  '${hour.toString().padLeft(2, '0')}:00',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.blue,
                  thickness: 1,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 60.w),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    color: Colors.white,
                    child: Card(
                      child: ListTile(
                        title: Text('Appointment'),
                        subtitle: Text('Details about the appointment'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
