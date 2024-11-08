import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EditProfileBloc>().add(GetUserByIdEvent(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa hồ sơ'),
        centerTitle: true,
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == BlocStatus.success) {
            // Chỉ cập nhật TextEditingController khi load thành công
            firstNameController.text = state.data.firstName;
            lastNameController.text = state.data.lastName;
            dateOfBirthController.text = state.data.dateOfBirth;
            usernameController.text = state.data.username;
            emailController.text = state.data.email;
            phoneController.text = state.data.phone;
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == BlocStatus.success) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text("Thông tin cá nhân"),
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/avatar_placeholder.png'),
                    ),
                    TextButton(
                        onPressed: () {}, child: Text("Chỉnh sửa avatar")),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Họ',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            firstNameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: firstNameController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            lastNameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: lastNameController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh',
                        hintText: 'DD/MM/YYYY',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            dateOfBirthController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: dateOfBirthController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text("Thông tin tài khoản"),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tên tài khoản',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            usernameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: usernameController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            emailController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: emailController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            phoneController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: phoneController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Lưu thay đổi hồ sơ
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("Lưu"),
                    ),
                  ],
                ),
              );
            } else if (state.status == BlocStatus.error) {
              return Center(child: Text("Đã xảy ra lỗi: ${state.status}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
