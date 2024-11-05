import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimelineSchedule extends StatefulWidget {
  const TimelineSchedule({super.key});

  @override
  State<TimelineSchedule> createState() => _TimelineScheduleState();
}

class _TimelineScheduleState extends State<TimelineSchedule> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        DateTime.now().hour * 100.h,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
    // scrollController.animateTo(
    //   DateTime.now().hour * 100.h,
    //   duration: Duration(seconds: 1),
    //   curve: Curves.easeIn,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 24,
      itemBuilder: (context, index) {
        return TimelineItem(hour: index, isNow: index == DateTime.now().hour);
      },
    );
  }
}

class TimelineItem extends StatelessWidget {
  final int hour;
  final bool isNow;

  const TimelineItem({super.key, required this.hour, this.isNow = false});

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
              if (isNow) ...[
                Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 20.r,
                )
              ],
              Expanded(
                child: Divider(
                  color: isNow ? Colors.red : Colors.blue,
                  thickness: isNow ? 2 : 1,
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
                  child: Card(
                    color: Color(0xFFf2e7eb),
                    child: ListTile(
                      title: Text('Appointment'),
                      subtitle: Text('Details about the appointment'),
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
