import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/utils/constants/firebase_ref.dart';
import 'package:health_management/domain/chat/chat/chat_model.dart';
import 'package:health_management/domain/chat/user/user_model.dart';
import 'package:health_management/firebase_service.dart';

abstract class ChatDataSource {
  Stream<List<Chat>> getChatContacts();

  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class MessageContactsRemoteDataSourceImpl implements ChatDataSource {
  final fireStore = FirebaseService.firestore;
  MessageContactsRemoteDataSourceImpl();
  @override
  Stream<List<Chat>> getChatContacts() {
    // The method first gets the currently authenticated user's uid from FirebaseAuth, and then queries the Firestore database for a collection of chat
    // messages for that user. The result of this query is a Stream of query snapshots.
    return fireStore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(SharedPreferenceManager.readUserId())
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      // The asyncMap method is used to transform each query snapshot into a List of ChatContactModel objects.
      List<Chat> messages = [];
      //For each query snapshot, the code iterates through the documents in the snapshot and creates a ChatContactModel object for each document.
      for (var document in event.docs) {
        var chatContact = Chat.fromMap(document.data());
        // get profile of the user from API
        //var profile = await UserRepository().getUserById(chatContact
        var userData = await fireStore
            .collection(FirebaseRef.USER_COLLECTION)
            .doc(chatContact.contactId)
            .get();
        var profile = UserModel.fromMap(userData.data()!);
        //Finally, a new ChatContactModel object is created by combining the information from the ChatContactModel and UserModel objects.
        // This new ChatContactModel object is added to a list of ChatContactModel objects
        messages.add(Chat(
            name: profile.userName,
            profileUrl: profile.profileImage,
            lastMessage: chatContact.lastMessage,
            lastMessageTime: chatContact.lastMessageTime,
            contactId: chatContact.contactId));
      }
      print('messages ${messages[0].name}');
      return messages;
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return fireStore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(SharedPreferenceManager.readUserId())
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }
}
