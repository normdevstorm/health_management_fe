import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/main.dart';
import 'package:health_management/presentation/appointment/ui/widgets/timeline_schedule.dart';
import 'package:health_management/presentation/common/button.dart';

class AppointmentHome extends StatelessWidget {
  const AppointmentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apr 08,2022',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Today',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                  icon: Icon(Icons.add), onPressed: () {}, label: Text("Add"))
            ]),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 3 ? Colors.blue : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ][index],
                        style: TextStyle(
                          fontSize: 14,
                          color: index == 3 ? Colors.white : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${index + 12}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: index == 3 ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            SizedBox(height: 200.r, child: TimelineSchedule()),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            const AppointmentCard(
              doctorType: 'Pediatrician',
              doctorName: 'Dr. Charollette Baker',
              time: '12:00-13:00',
              isCompleted: false,
            ),
            const AppointmentCard(
              doctorType: 'Pediatrician',
              doctorName: 'Dr. Charollette Baker',
              time: '12:00-13:00',
              isCompleted: false,
            ),
            const AppointmentCard(
              doctorType: 'Pediatrician',
              doctorName: 'Dr. Charollette Baker',
              time: '12:00-13:00',
              isCompleted: false,
            ),
            const AppointmentCard(
              doctorType: 'Pediatrician',
              doctorName: 'Dr. Charollette Baker',
              time: '12:00-13:00',
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorType;
  final String doctorName;
  final String time;
  final bool isCompleted;

  const AppointmentCard({
    super.key,
    required this.doctorType,
    required this.doctorName,
    required this.time,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  doctorType,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          'Apr 08,2022',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'images/placeholder.png',
                    width: 100.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          if (!isCompleted) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Reschedule'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ScheduleTimeline extends StatefulWidget {
  const ScheduleTimeline({super.key});

  @override
  State<ScheduleTimeline> createState() => _ScheduleTimelineState();
}

class _ScheduleTimelineState extends State<ScheduleTimeline> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time line
                    Timeline(
                      scrollController: _scrollController,
                      items: [
                        TimelineItem(
                          time: '09:00',
                          content: Container(
                            height: 40,
                            color: Colors.blue,
                          ),
                        ),
                        TimelineItem(
                          time: '10:00',
                          content: AppointmentCard(
                            doctorType: 'Cardiologist',
                            doctorName: 'Dan Johnson',
                            time: '10:00-11:00',
                            isCompleted: true,
                          ),
                        ),
                        TimelineItem(
                          time: '11:00',
                          content: Container(
                            height: 40,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.time,
    required this.content,
  });

  final String time;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(time),
        const SizedBox(width: 16),
        content,
      ],
    );
  }
}

class Timeline extends StatelessWidget {
  const Timeline({
    super.key,
    required this.scrollController,
    required this.items,
  });

  final ScrollController? scrollController;
  final List<TimelineItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}
