import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/size_manager.dart';

import '../widgets/common_separator.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSection(
              context,
              child: _buildDateTimeBox(),
            ),
            _buildSection(
              context,
              child: _buildHealthProviderBox(),
            ),
            const SizedBox(width: 8),
            _buildSection(
              context,
              child: _buildDoctorDetailsBox(),
            ),
            Row(
              children: [
                Expanded(
                  child: _buildSection(
                    context,
                    child: _buildNotesBox(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSection(
                    context,
                    child: _buildPrescriptionBox(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        // border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget _buildDateTimeBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding:
              EdgeInsets.only(left: 5.w, right: 25.w, top: 5.h, bottom: 5.h),
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('JUN 9', style: TextStyle(fontSize: 30.sp))),
              Text('Wednesday', style: TextStyle(fontSize: 16.sp)),
              10.verticalSpace,
            ],
          ),
        ),
        8.horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding:
              EdgeInsets.only(left: 5.w, right: 25.w, top: 5.h, bottom: 5.h),
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text('10:00 AM', style: TextStyle(fontSize: 30.sp))),
              Text('Time', style: TextStyle(fontSize: 16.sp)),
              10.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthProviderBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent)),
              child: Icon(
                Icons.local_hospital,
                size: 35.r,
                color: Colors.blueAccent,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text('Health Provider Name',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text('Hanoi', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('District',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text('Thanh Xuan', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Street',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                Text('Tran Phu', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ],
        ),
        8.verticalSpace,
        CommonSeparator(
          height: 1.sp,
          color: Colors.grey.shade400,
        ),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Text("Distance"),
                Text("1 KM AWAY"),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                fit: BoxFit.fitWidth,
                'assets/images/placeholder.png',
                width: 200.w,
                height: 80.h,
              ),
            ),
          ],
        ),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  // elevation: WidgetStateProperty.all(10.h),
                  backgroundColor: WidgetStateProperty.all(
                      ColorManager.buttonEnabledColorLight),
                  fixedSize: WidgetStatePropertyAll(Size(140.w, 35.h))),
              onPressed: () {},
              child: const Text(
                'Copy Direction',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  // elevation: WidgetStateProperty.all(10.h),
                  backgroundColor: WidgetStateProperty.all(
                      ColorManager.buttonEnabledColorLight),
                  fixedSize: WidgetStatePropertyAll(Size(140.w, 35.h))),
              onPressed: () {},
              child: const Text(
                'Open Maps',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        10.verticalSpace,
      ],
    );
  }

  Widget _buildDoctorDetailsBox() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Doctor Details:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Doctor Name', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildNotesBox() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Some notes about the appointment',
            style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildPrescriptionBox() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prescription:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Prescription details', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
