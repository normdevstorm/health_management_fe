import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';

import '../../../bloc/user/user_cubit.dart';

class ContactProfilePage extends StatelessWidget {
  static const String routeName = 'contact_profile';
  final String uid;
  final String name;
  final String imageUrl;

  const ContactProfilePage({
    Key? key,
    required this.uid,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getProfile(uid);
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GetProfileSuccess) {
                  print('Profile: ${state.profile}');
                  return _buildUserProfile(state.profile);
                } else if (state is UserError) {
                  // Xử lý lỗi nếu có
                  return Text(state.message);
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(ChatProfile profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 50,
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
