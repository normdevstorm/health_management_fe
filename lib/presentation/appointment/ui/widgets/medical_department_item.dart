import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/presentation/common/select_item_widget.dart';

class MedicalDepartmentItem extends StatelessWidget {
  final String departmentName;
  final int doctorsCount;
  final VoidCallback? onTap;
  final bool isSelected;

  const MedicalDepartmentItem({
    super.key,
    required this.departmentName,
    required this.doctorsCount,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SelectItemWidget(
      onTap: onTap,
      isSelected: isSelected,
      margin: EdgeInsets.only(left: 10.w),
      child: Card(
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
      ),
    );
  }
}
