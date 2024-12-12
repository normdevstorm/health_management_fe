import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';
import 'package:health_management/data/user/models/request/update_user_request.dart';
import 'package:health_management/data/user/models/response/user_response.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/domain/user/repositories/user_repository.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../api/user_api.dart';
import '../models/response/user_summary_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi api;
  final Logger logger;
  final firestore = FirebaseService.firestore;
  final fireStorage = FirebaseService.storage;
  final auth = FirebaseService.auth;

  UserRepositoryImpl(this.api, this.logger);

  @override
  Future<String> deleteUser(int userId) async {
    try {
      return await api.deleteUser(userId);
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<UserEntity>> getDoctors() async {
    try {
      ApiResponse apiResponse = await api.getDoctors();
      List<UserEntity> doctors = (apiResponse.data as List<UserResponse>)
          .map((doctor) => doctor.toEntity())
          .toList();
      return doctors;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<UserEntity>> getPatients() async {
    try {
      ApiResponse apiResponse = await api.getPatients();
      List<UserEntity> patients = (apiResponse.data as List<UserResponse>)
          .map((patient) => patient.toEntity())
          .toList();
      return patients;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<DoctorEntity>> getTopRatedDoctors() async {
    try {
      ApiResponse apiResponse = await api.getTopRatedDoctors();
      List<DoctorEntity> doctors = (apiResponse.data as List<DoctorResponse>)
          .map((doctor) => doctor.toEntity())
          .toList();
      return doctors;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> getUserByEmail(String email) async {
    try {
      ApiResponse apiResponse = await api.getUserByEmail(email);
      UserEntity user = (apiResponse.data as UserSummaryResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> getUserSummary(int id) async {
    try {
      ApiResponse apiResponse = await api.getUserSummary(id);
      UserEntity user = (apiResponse.data as UserSummaryResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<UserEntity> updateUser(
      UpdateUserRequest updateUserRequest, int? userId) async {
    try {
      ApiResponse apiResponse = await api.updateUser(updateUserRequest, userId);
      UserEntity user = (apiResponse.data as UserResponse).toEntity();
      return user;
    } catch (e) {
      throw ApiException.getDioException(e);
    }
  }

  // @override
  // Future<UserEntity> getUserById() async {
  //   try {
  //     ApiResponse apiResponse = await api.getUserById();
  //     UserEntity user = (apiResponse.data as UserResponse).toEntity();
  //     return user;
  //   } catch (e) {
  //     throw ApiException.getDioException(e);
  //   }
  // }
  @override
  Future<List<String>> uploadImageToFirebase(
      List<String> imgPaths, UploadImageType ref) async {
    List<String> imgUrl = [];
    switch (ref) {
      case UploadImageType.profile:
        String uid = auth.currentUser!.uid;
        imgPaths.forEach(
          (element) async {
            String photoUrl = await _storeFileToFirebase(
              'profilePicture/$uid',
              File(element),
            );
            await firestore.collection("users").doc(uid).update({
              'profileImage': photoUrl,
            });
            await firestore.collection("profiles").doc(uid).update({
              'avatar': photoUrl,
            });
            imgUrl.add(photoUrl);
          },
        );
        break;
      case UploadImageType.article:
        imgPaths.forEach(
          (element) async {
            String random = const Uuid().v4();
            String photoUrl = await _storeFileToFirebase(
              'articlePicture/$random',
              File(element),
            );

            imgUrl.add(photoUrl);
          },
        );

        break;
      default:
    }
    return imgUrl;
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = fireStorage.ref().child(path).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    //return the download URL of the uploaded file
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
