import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';

class HealthProvider {
  final String name;
  final String location;
  final String address;
  final String distance;
  final String openingHours;
  final String imageUrl;

  HealthProvider({
    required this.name,
    required this.location,
    required this.address,
    required this.distance,
    required this.openingHours,
    required this.imageUrl,
  });
}

class ChooseHealthProviderScreen extends StatelessWidget {
  final List<HealthProvider> healthProviders = [
    HealthProvider(
      name: 'Health Provider 1',
      location: 'https://maps.google.com/?q=Health+Provider+1',
      address: '123 Main St, City, Country',
      distance: '2 km',
      openingHours: '9 AM - 5 PM',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    HealthProvider(
      name: 'Health Provider 2',
      location: 'https://maps.google.com/?q=Health+Provider+2',
      address: '456 Elm St, City, Country',
      distance: '5 km',
      openingHours: '8 AM - 6 PM',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    HealthProvider(
      name: 'Health Provider 3',
      location: 'https://maps.google.com/?q=Health+Provider+3',
      address: '789 Oak St, City, Country',
      distance: '3 km',
      openingHours: '10 AM - 4 PM',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    HealthProvider(
      name: 'Health Provider 4',
      location: 'https://maps.google.com/?q=Health+Provider+4',
      address: '101 Pine St, City, Country',
      distance: '1 km',
      openingHours: '7 AM - 3 PM',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  ChooseHealthProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      20.verticalSpace,
      Text(
        "Health Provider",
        style: StyleManager.title.copyWith(fontSize: 20.sp),
      ),
      10.verticalSpace,
      SizedBox(
        height: 200.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: healthProviders.length,
          itemBuilder: (context, index) {
            final provider = healthProviders[index];
            return HealthProviderItem(
              title: provider.name,
              address: provider.address,
              distance: provider.distance,
              icon: Icons.local_hospital,
            );
          },
        ),
      ),
      20.verticalSpace,
      Text(
        "Health Department",
        style: StyleManager.title.copyWith(fontSize: 20.sp),
      ),
      10.verticalSpace,
      SizedBox(
        height: 250.h,
        child: MedicalDepartmentListView(),
      )
    ]);
  }
}

class HealthProviderItem extends StatelessWidget {
  final String title;
  final String address;
  final String distance;
  final IconData icon;

  const HealthProviderItem({
    super.key,
    required this.title,
    required this.address,
    required this.distance,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: ColorManager.cardColorLight,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 32.0,
                  color: Colors.green,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        address,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFFe9f5f3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.location_circle,
                      color: Color(0xFF629d92)),
                  Text(
                    distance,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalDepartmentListView extends StatelessWidget {
  const MedicalDepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) {
        return MedicalDepartmentItem(
          departmentName: index == 0 ? 'Cardio' : 'Dental',
          doctorsCount: index == 0 ? 12 : 9,
        );
      },
    );
  }
}

class MedicalDepartmentItem extends StatelessWidget {
  final String departmentName;
  final int doctorsCount;

  const MedicalDepartmentItem({
    super.key,
    required this.departmentName,
    required this.doctorsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon for the department
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    departmentName == 'Cardio' ? Colors.purple : Colors.blue,
                child: Icon(
                  departmentName == 'Cardio'
                      ? Icons.favorite
                      : Icons.monitor_heart,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(height: 10.h),
              // Department name and doctors count
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departmentName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$doctorsCount doctors',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              // Placeholder for doctor avatars
              Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                children: [
                  // Background
                  SizedBox(
                    width: 250.w,
                    height: 50.h,
                  ),
                  // Doctor avatars
                  Positioned(
                    left: 0,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: AssetImage(
                        '/images/placeholder.png',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: AssetImage(
                        '/images/placeholder.png',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: AssetImage(
                        '/images/placeholder.png',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: AssetImage(
                        '/images/placeholder.png',
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
