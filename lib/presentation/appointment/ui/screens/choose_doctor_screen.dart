import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/size_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/appointment/bloc/appointment/appointment_bloc.dart';

class ChooseDoctorScreen extends StatelessWidget {
  final List<UserEntity> doctors;
  const ChooseDoctorScreen({required this.doctors, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(
            onTap: () {
              if (doctor.doctorProfile?.id != null) {
                context.read<AppointmentBloc>().add(
                    ColectDataDoctorEvent(doctorId: doctor.doctorProfile!.id!));
                context.pushNamed(RouteDefine.createAppointmentChooseTime);
              }
            },
            doctorName: '${doctor.firstName} ${doctor.lastName}',
            doctorSpecialization: doctor.doctorProfile?.specialization?.name.toUpperCase() ?? "",
            experience: doctor.doctorProfile?.experience.toString() ?? "",
            reviews: doctor.doctorProfile?.rating.toString() ?? "",
            image: 'assets/images/placeholder.png',
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String experience;
  final String reviews;
  final String image;
  final VoidCallback? onTap;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.experience,
    required this.reviews,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.backgroundColorLight,
          //TODO: add border color when the card is selected, otherwise remove the border ans use shadow
          // border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            60.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  Text(
                    doctorSpecialization,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  10.verticalSpace,
                  Text(
                    'Experience: $experience',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < double.parse(reviews).round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        );
                      }),
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
