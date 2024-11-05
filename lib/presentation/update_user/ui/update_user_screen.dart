// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileBloc(),
//       child: Scaffold(
//         appBar: AppBar(title: Text("Update Profile")),
//         body: BlocConsumer<ProfileBloc, ProfileState>(
//           listener: (context, state) {
//             if (state is ProfileUpdateSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Profile updated successfully!")),
//               );
//             } else if (state is ProfileUpdateFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Update failed: ${state.error}")),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Các TextField để nhập thông tin profile của người dùng...
//                   ElevatedButton(
//                     onPressed: () {
//                       // Lấy dữ liệu từ TextFields để tạo event
//                       context.read<ProfileBloc>().add(
//                             ProfileUpdateSubmitted(
//                               firstName: 'John',
//                               lastName: 'Doe',
//                               dateOfBirth: DateTime(1990, 5, 15),
//                               gender: 'Male',
//                               avatarUrl: 'https://example.com/avatar.jpg',
//                               account: UpdateAccountRequest(
//                                 username: 'johndoe',
//                                 email: 'john@example.com',
//                                 password: 'password123',
//                                 phone: '123-456-7890',
//                               ),
//                               addresses: {
//                                 AddressDTO(
//                                   id: 1,
//                                   unitNumber: '12A',
//                                   streetNumber: '123',
//                                   addressLine1: 'Street 1',
//                                   addressLine2: 'Building B',
//                                   city: 'Cityname',
//                                   region: 'Region',
//                                   postalCode: '000000',
//                                   country: 'Country',
//                                   isDefault: true,
//                                 )
//                               },
//                               doctorProfile: null,
//                               userId: 3,
//                               role: 'USER',
//                             ),
//                           );
//                     },
//                     child: Text('Update Profile'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
