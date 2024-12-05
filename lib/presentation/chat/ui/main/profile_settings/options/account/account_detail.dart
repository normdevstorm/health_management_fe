import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/presentation/chat/bloc/user/user_cubit.dart';

class AccountDetails extends StatelessWidget {
  static const routeName = 'account-details';
  final String uid;

  const AccountDetails({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            BlocProvider.of<UserCubit>(context, listen: false).getProfile(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            ChatProfile? profile = context.read<UserCubit>().profile;
            print('profile: $profile');
            if (profile != null) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Account Details'),
                  ),
                  body: Column(children: [
                    ListTile(
                      title: const Text('Email',
                          style: TextStyle(fontSize: 20, color: Colors.red)),
                      subtitle: Text(profile.email),
                      onTap: () {
                        //dialog change password
                        _changePasswordDialog(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Username'),
                      subtitle: Text(profile.userName),
                    ),
                    ListTile(
                      title: const Text('Phone'),
                      subtitle: Text(profile.phone ?? 'Not provided yet'),
                    ),
                    ListTile(
                      title: const Text('Address'),
                      subtitle: Text(profile.phone ?? 'Not provided yet'),
                    ),
                    ListTile(
                      title: const Text('Birthday'),
                      subtitle: Text(profile.phone ?? 'Not provided yet'),
                    ),
                    ListTile(
                      title: const Text('Gender'),
                      subtitle: Text(profile.phone ?? 'Not provided yet'),
                    ),
                  ]));
            }
          }
          return const SizedBox();
        });
  }

  void _changePasswordDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Change Password'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Old password'),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'New password'),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Confirm new password'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  //change password
                },
                child: const Text('Change'),
              ),
            ],
          );
        });
  }
}
