import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/domain/chat/models/user_model.dart';

abstract class ContactsRemoteDataSource {
  Future<List<UserChatModel>> getAllContacts();
}

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  final _firebaseFirestore = FirebaseService.firestore;
  final _firebaseAuth = FirebaseService.auth;
  @override
  Future<List<UserChatModel>> getAllContacts() async {
    //get all exists contacts by get all users from firebase
    final List<UserChatModel> allUsers = [];
    final users = await _firebaseFirestore.collection('users').get();
    for (var user in users.docs) {
      //todo: change the id to the current user id
      if (user.id != _firebaseAuth.currentUser!.uid) {
        //convert to Contact object
        final result = UserChatModel.fromMap(user.data());
        allUsers.add(result);
      }
    }
    return allUsers;
  }
}
