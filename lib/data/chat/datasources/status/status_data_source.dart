// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:health_management/app/utils/errors/exception.dart';
import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/domain/chat/models/status_model.dart';
import 'package:uuid/uuid.dart';

abstract class StatusRemoteDataSource {
  Future<void> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption});

  Stream<List<StatusModel>> getStatus();
}

class StatusRemoteDataSourceImpl extends StatusRemoteDataSource {
  final firestore = FirebaseService.firestore;
  final auth = FirebaseService.auth;
  final firebaseStorage = FirebaseService.storage;

  StatusRemoteDataSourceImpl();

  //The uploadStatus method is a function that is used to upload a user's status to a Firebase Firestore database.
  @override
  Future<void> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) async {
    try {
      List<String> statusImageUrls = [];
      List<String> statusCaptions = [];
      List<DateTime> statusCreatedAt = [];
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;

      var imageUrl = await _storeFileToFirebase(
        'status/$statusId/$uid',
        statusImage,
      );

      var statusesSnapshot = await firestore
          .collection("status")
          .where("uid", isEqualTo: uid)
          .get();

      //if the user has already uploaded a status, the method updates the existing status with the new image URL, caption and create time.
      if (statusesSnapshot.docs.isNotEmpty) {
        StatusModel status =
            StatusModel.fromMap(statusesSnapshot.docs[0].data());
        print('status: $status');

        statusImageUrls = status.photoUrl;
        statusImageUrls.add(imageUrl);

        statusCaptions = status.caption;
        statusCaptions.add(caption);

        statusCreatedAt = status.createdAt;
        statusCreatedAt.add(DateTime.now());
        await firestore
            .collection("status")
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'caption': statusCaptions,
          'photoUrl': statusImageUrls,
          'createdAt':
              statusCreatedAt.map((e) => e.millisecondsSinceEpoch).toList(),
        });
        return;
      } else {
        statusImageUrls = [imageUrl];
        statusCaptions = [caption];
        statusCreatedAt = [DateTime.now()];
      }

      StatusModel status = StatusModel(
          uid: uid,
          username: username,
          photoUrl: statusImageUrls,
          createdAt: statusCreatedAt,
          profilePicture: profilePicture,
          statusId: statusId,
          idOnAppUser: uidOnAppContact,
          caption: statusCaptions);

      await firestore.collection("status").doc(statusId).set(status.toMap());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    //First, the method creates an UploadTask object using the putFile method of the Firebase Storage reference. The path parameter is used as
    // the path of the file in Firebase Storage, and the file parameter is used as the actual file to be uploaded
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    //Next, the method waits for the upload to complete by awaiting the UploadTask object. The result of the upload is a TaskSnapshot object,
    // which contains information about the uploaded file, such as its download URL.
    TaskSnapshot snapshot = await uploadTask;
    //Finally, the method gets the download URL of the uploaded file by calling the getDownloadURL method on the TaskSnapshot object, and returns it as a String.
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //The getStatus function appears to be a method of a class that retrieves a list of status updates from a Firestore collection.
  @override
  Stream<List<StatusModel>> getStatus() async* {
    try {
      final List<StatusModel> statusData = [];

      // Tính thời gian trước 24 giờ
      DateTime twentyFourHoursAgo =
          DateTime.now().subtract(const Duration(hours: 24));
      // Truy vấn các tài liệu trong 24 giờ gần đây
      Query<Map<String, dynamic>> query = firestore.collection("status");

      // Lắng nghe thay đổi trong truy vấn
      await for (QuerySnapshot<Map<String, dynamic>> statusesSnapshot
          in query.snapshots()) {
        // Xử lý dữ liệu mới
        for (var doc in statusesSnapshot.docs) {
          final List<int> createdAtList =
              (doc.data()['createdAt'] as List<dynamic>).cast<int>();
          final int lastCreatedAt = createdAtList.last;
          final DateTime lastCreatedAtDateTime =
              DateTime.fromMillisecondsSinceEpoch(lastCreatedAt);

          // Kiểm tra nếu giá trị cuối cùng của createdAt nhỏ hơn 24 giờ trước
          if (lastCreatedAtDateTime.isAfter(twentyFourHoursAgo)) {
            final StatusModel tempStatus = StatusModel.fromMap(doc.data());
            statusData.add(tempStatus);
          }
        }

        // Yield dữ liệu mới
        yield statusData.toList();
        print('statusData: $statusData'); // []
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw ServerException(e.toString());
    }
  }
}
