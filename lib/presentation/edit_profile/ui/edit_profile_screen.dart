import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/route/route_define.dart';
import '../../chat/bloc/user/user_cubit.dart';

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
  final ValueNotifier<bool> isUpdatingAvatarNotifier = ValueNotifier(false);
  File? _imageFile;

  String? selectedGender;
  String avatarUrl = ConstantManager.defaultProfileAvatar;
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<EditProfileBloc, EditProfileState>(
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
                avatarUrl =
                    data.avatarUrl ?? ConstantManager.defaultProfileAvatar;
              } else if (state.status == BlocStatus.error) {
                // Hiển thị thông báo lỗi nếu có lỗi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Đã xảy ra lỗi: //${state.errorMessage}')),
                );
              }
            },
          ),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UpdateProfileImageSuccess) {
                context.read<UserCubit>().getCurrentUser();
                // Cập nhật lại avatarUrl sau khi cập nhật thành công
                return;
              }
              if (state is UserError) {
                ToastManager.showToast(
                    context: context, message: 'Profile picture update failed');
                return;
              }
            },
          ),
        ],
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
                    ValueListenableBuilder(
                      valueListenable: isUpdatingAvatarNotifier,
                      builder: (context, isUpdatingAvatar, child) =>
                          CircleAvatar(
                        radius: 40.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: !isUpdatingAvatar
                              ? Image.network(
                                  avatarUrl,
                                )
                              : Image.file(
                                  File(avatarUrl),
                                ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          final selectedAvatar = await _selectAvatar();
                          if (selectedAvatar != null) {
                            isUpdatingAvatarNotifier.value = false;
                            avatarUrl = selectedAvatar;
                            isUpdatingAvatarNotifier.value = true;
                          }
                        },
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
                        await _saveEditedProfile(context);
                        isUpdatingAvatarNotifier.value = false;
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

  Future<void> _saveEditedProfile(BuildContext context) async {
    final ProfileUpdateSubmittedEvent profileUpdateSubmittedEvent =
        await _collectEditedProfileData(context);
    context.read<EditProfileBloc>().add(profileUpdateSubmittedEvent);
  }

  Future<ProfileUpdateSubmittedEvent> _collectEditedProfileData(
      BuildContext context) async {
    final profileImage = await _saveAvatar(avatarUrl);
    final user = await SharedPreferenceManager.getUser();
    final userId = user?.id ?? 0;

    final userEntity = UserEntity(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: selectedGender,
      avatarUrl: profileImage,
    );

    final accountEntity = AccountEntity(
      id: userId,
      email: emailController.text,
      phone: phoneController.text,
    );

    return ProfileUpdateSubmittedEvent(
      userEntity,
      accountEntity,
    );
  }

  Future<String?> _selectAvatar() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _imageFile = File(image.path);
        _imageFile = await GoRouter.of(context)
            .pushNamed(RouteDefine.avatarPreview, extra: _imageFile);
        if (_imageFile != null) {
          //update avatar
          await context.read<UserCubit>().updateProfileImage(_imageFile!.path);
          avatarUrl = _imageFile!.path;
          return avatarUrl;
        }
      }
      return null;
    } catch (e) {
      print('Image picking error: $e');
    }
    return null;
  }

  Future<String?> _saveAvatar(String profileImage) async {
    if (context.read<UserCubit>().userModel?.profileImage != null) {
      final String profileImageFromFirebase =
          context.read<UserCubit>().userModel!.profileImage;
      return profileImageFromFirebase;
    }
    return null;
  }
}
