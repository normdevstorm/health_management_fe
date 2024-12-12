import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedGender;
  String avatarUrl =
      'https://www.nylabone.com/-/media/project/oneweb/nylabone/images/dog101/10-intelligent-dog-breeds/golden-retriever-tongue-out.jpg';
  @override
  void initState() {
    super.initState();
    // Lấy thông tin người dùng khi vào màn hình
    context.read<EditProfileBloc>().add(const GetInformationUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa hồ sơ'),
        centerTitle: true,
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == BlocStatus.success) {
            UserEntity data = state.data as UserEntity;
            // Cập nhật giá trị cho TextEditingController sau khi tải dữ liệu thành công
            firstNameController.text = data.firstName ?? '';
            lastNameController.text = data.lastName ?? '';
            dateOfBirthController.text = data.dateOfBirth.toString();
            emailController.text = data.account?.email ?? '';
            phoneController.text = data.account?.phone ?? '';
            selectedGender = data.gender;
          } else if (state.status == BlocStatus.error) {
            // Hiển thị thông báo lỗi nếu có lỗi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã xảy ra lỗi: ${state.errorMessage}')),
            );
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 40,
                      child: Image.network(
                        "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg",
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Chỉnh sửa avatar")),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Họ',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            firstNameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: firstNameController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            lastNameController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: lastNameController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      items: [
                        DropdownMenuItem(
                          value: 'MALE',
                          child: Container(
                            width: 60,
                            alignment: Alignment.centerLeft,
                            child: const Text('Male',
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'FEMALE',
                          child: Container(
                            width: 80.w,
                            alignment: Alignment.centerLeft,
                            child: const Text('Female',
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: selectedGender == null ? 'Giới Tính' : '',
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      controller: dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh',
                        hintText: 'YYYY/MM/DD',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            dateOfBirthController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: dateOfBirthController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    const Text("Thông tin tài khoản"),
                    16.verticalSpace,
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            emailController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: emailController.text.length,
                            );
                          },
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit),
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
                      onPressed: () async {
                        final user = await SharedPreferenceManager.getUser();
                        final userId = user?.id ?? 0;

                        final userEntity = UserEntity(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          gender: selectedGender,
                        );

                        final accountEntity = AccountEntity(
                          id: userId,
                          email: emailController.text,
                          phone: phoneController.text,
                        );

                        context.read<EditProfileBloc>().add(
                              ProfileUpdateSubmittedEvent(
                                userEntity,
                                accountEntity,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Lưu"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
