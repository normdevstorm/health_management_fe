// // profile_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'update_user_event.dart';
// import 'update_user_state.dart';

// class UpdateProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final UpdateUserUseCase updateUserUseCase;
//   UpdateProfileBloc() : super(ProfileInitial()) {
//     on<ProfileUpdateSubmitted>(_onProfileUpdateSubmitted);
//   }

//   Future<void> _onProfileUpdateSubmitted(
//       ProfileUpdateSubmitted event, Emitter<ProfileState> emit) async {
//     emit(ProfileLoading());

//     try {
//       // Kiểm tra quyền để đảm bảo user chỉ cập nhật profile của chính mình
//       if (event.userId != 3) {
//         // Ví dụ lấy ID 3 cho người dùng hiện tại
//         throw Exception("Không thể cập nhật profile người dùng khác.");
//       }

//       // Điều kiện xử lý cập nhật cho từng role
//       if (event.role == 'DOCTOR' && event.doctorProfile == null) {
//         throw Exception(
//             "Cần cung cấp thông tin doctorProfile cho vai trò DOCTOR.");
//       } else if (event.role == 'USER' && event.doctorProfile != null) {
//         throw Exception(
//             "Người dùng với vai trò USER không thể cập nhật doctorProfile.");
//       }

//       // Giả lập API để cập nhật hồ sơ
//       await Future.delayed(Duration(seconds: 2));

//       emit(ProfileUpdateSuccess());
//     } catch (error) {
//       emit(ProfileUpdateFailure(error.toString()));
//     }
//   }
// }
