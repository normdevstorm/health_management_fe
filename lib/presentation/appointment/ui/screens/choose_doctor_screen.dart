import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/size_manager.dart';
import 'package:health_management/main.dart';

class ChooseDoctorScreen extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. John Doe',
      'specialization': 'Cardiologist',
      'experience': '10 years',
      'reviews': '4',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Jane Smith',
      'specialization': 'Dermatologist',
      'experience': '8 years',
      'reviews': '5',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Emily Clark',
      'specialization': 'Pediatrician',
      'experience': '12 years',
      'reviews': '4',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Michael Brown',
      'specialization': 'Orthopedic',
      'experience': '15 years',
      'reviews': '5',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Sarah Wilson',
      'specialization': 'Neurologist',
      'experience': '9 years',
      'reviews': '4',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. David Lee',
      'specialization': 'Psychiatrist',
      'experience': '7 years',
      'reviews': '3',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Laura Martinez',
      'specialization': 'Gynecologist',
      'experience': '11 years',
      'reviews': '5',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. James Anderson',
      'specialization': 'Oncologist',
      'experience': '10 years',
      'reviews': '4',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Patricia Thomas',
      'specialization': 'Radiologist',
      'experience': '8 years',
      'reviews': '4',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Robert Jackson',
      'specialization': 'Urologist',
      'experience': '13 years',
      'reviews': '5',
      'image': '/images/placeholder.png',
    },
    {
      'name': 'Dr. Linda White',
      'specialization': 'Endocrinologist',
      'experience': '6 years',
      'reviews': '3',
      'image': '/images/placeholder.png',
    },
    // Add more doctors here
  ];

  ChooseDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorCard(
          doctorName: doctor['name']!,
          doctorSpecialization: doctor['specialization']!,
          experience: doctor['experience']!,
          reviews: doctor['reviews']!,
          image: doctor['image']!,
        );
      },
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String experience;
  final String reviews;
  final String image;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.experience,
    required this.reviews,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: Offset(0, 3),
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
                  offset: Offset(0, 3),
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
    );
  }
}
