import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_management/app/utils/constants/firebase_ref.dart';
import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserChatModel?> getCurrentUserData();
  Stream<UserChatModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
  Future<void> updateProfile(ChatProfile newProfile);
  Future<void> updateAccount(String newPassword);
  Future<ChatProfile> getProfile(String uid);
  Future<void> insertProfile(ChatProfile profile);
  Future<void> insertAccount(ChatAccount account);
  Future<void> insertUser(UserChatModel user);
  Future<void> updateProfileImage(String path);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final firestore = FirebaseService.firestore;
  final fireStorage = FirebaseService.storage;
  final auth = FirebaseService.auth;
  @override
  Future<UserChatModel?> getCurrentUserData() async {
    UserChatModel? userData;
    try {
      userData = await firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) => UserChatModel.fromMap(value.data()!));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    // ignore: avoid_print
    print(userData?.uid);

    return userData;
  }

  @override
  Stream<UserChatModel> getUserById(String id) {
    return firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(id)
        .snapshots()
        .map((event) => UserChatModel.fromMap(event.data()!));
  }

  @override
  Future<void> setUserStateStatus(bool isOnline) async {
    await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updateAccount(String newPassword) async {
    await firestore
        .collection(FirebaseRef.ACCOUNT_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({'password': newPassword});
  }

  @override
  Future<void> updateProfile(ChatProfile newProfile) async {
    await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update(newProfile.toMap());
  }

  @override
  Future<ChatProfile> getProfile(String uid) async {
    return await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(uid)
        .get()
        .then((value) => ChatProfile.fromMap(value.data()!));
  }

  @override
  Future<void> insertProfile(ChatProfile profile) async {
    await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .set(profile.toMap());
  }

  @override
  Future<void> insertAccount(ChatAccount account) async {
    await firestore
        .collection(FirebaseRef.ACCOUNT_COLLECTION)
        .doc(auth.currentUser!.uid)
        .set(account.toMap());
  }

  @override
  Future<void> insertUser(UserChatModel user) async {
    return await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<void> updateProfileImage(String path) async {
    String uid = auth.currentUser!.uid;
    //The method first deletes the previous profile picture by checking if the user has a profile picture and calling the _deleteFileFromFirebase method
    // to remove the file from Firebase storage.
    var userData = await firestore.collection('users').doc(uid).get();
    UserChatModel user = UserChatModel.fromMap(userData.data()!);
    if (user.profileImage.isNotEmpty &&
        user.profileImage !=
            'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png') {
      await _deleteFileFromFirebase(user.profileImage);
    }
    //Then it uploads the new profile picture using the _storeFileToFirebase method and stores the download URL of the new picture in the Firestore database.
    String photoUrl = await _storeFileToFirebase(
      'profilePicture/$uid',
      File(path),
    );
    await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({
      'profileImage': photoUrl,
    });
    await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({
      'avatar': photoUrl,
    });

    //update the profileUrl in status collection
    await firestore
        .collection("status")
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        firestore.collection("status").doc(doc.id).update({
          'profilePicture': photoUrl,
        });
      }
    });

    updateProfileImageInChat(uid, photoUrl);
  }

  Future<void> updateProfileImageInChat(String uid, String photoUrl) async {
    var chats = await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(uid)
        .collection('chats')
        .get();
    for (var chat in chats.docs) {
      //update the profileUrl field of chat documents which chat.id matched uid
      await firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(uid)
          .collection('chats')
          .doc(chat.id)
          .update({
        'profileUrl': photoUrl,
      });
    }
  }

  //This is method deletes a file from Firebase Storage.
  Future<void> _deleteFileFromFirebase(String path) async {
    return await fireStorage.refFromURL(path).delete();
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
