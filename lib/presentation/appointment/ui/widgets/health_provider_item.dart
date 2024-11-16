import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/common/select_item_widget.dart';

class HealthProviderItem extends StatelessWidget {
  final String title;
  final String address;
  final String distance;
  final IconData icon;
  final List<UserEntity> doctors;
  final VoidCallback? onTap;
  final bool isSelected;

  const HealthProviderItem({
    super.key,
    required this.title,
    required this.address,
    required this.distance,
    required this.icon,
    required this.doctors,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SelectItemWidget(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      onTap: onTap,
      isSelected: isSelected,
      child: Container(
        width: 250.w,
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
                color: const Color(0xFFe9f5f3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(CupertinoIcons.location_circle,
                      color: const Color(0xFF629d92)),
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
