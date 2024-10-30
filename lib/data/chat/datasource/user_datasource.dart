import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/utils/constants/firebase_ref.dart';
import 'package:health_management/domain/chat/user/user_model.dart';
import 'package:health_management/firebase_service.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
  Future<void> insertUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final firestore = FirebaseService.firestore;
  final fireStorage = FirebaseService.storage;
  @override
  Future<UserModel?> getCurrentUserData() async {
    UserModel? userData;
    try {
      userData = await firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(SharedPreferenceManager.readUserId())
          .get()
          .then((value) => UserModel.fromMap(value.data()!));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    // ignore: avoid_print
    print(userData?.uid);

    return userData;
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  @override
  Future<void> setUserStateStatus(bool isOnline) async {
    await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(SharedPreferenceManager.readUserId())
        .update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> insertUser(UserModel user) async {
    return await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(user.uid)
        .set(user.toMap());
  }
}
