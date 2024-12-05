// ignore_for_file: avoid_print

import 'package:health_management/app/utils/constants/firebase_ref.dart';
import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/domain/chat/models/chat_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';

abstract class ChatContactsRemoteDataSource {
  Stream<List<Chat>> getChatContacts();

  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class MessageContactsRemoteDataSourceImpl
    implements ChatContactsRemoteDataSource {
  final fireStore = FirebaseService.firestore;
  final auth = FirebaseService.auth;
  MessageContactsRemoteDataSourceImpl();
  @override
  Stream<List<Chat>> getChatContacts() {
    // The method first gets the currently authenticated user's uid from FirebaseAuth, and then queries the Firestore database for a collection of chat
    // messages for that user. The result of this query is a Stream of query snapshots.
    return fireStore
        .collection(FirebaseRef.USER_COLLECTION)
        //todo: change the id to the current user id
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      // The asyncMap method is used to transform each query snapshot into a List of ChatContactModel objects.
      List<Chat> messages = [];
      //For each query snapshot, the code iterates through the documents in the snapshot and creates a ChatContactModel object for each document.
      for (var document in event.docs) {
        var chatContact = Chat.fromMap(document.data());
        //Then, another query is made to fetch the user data of the corresponding contact using the contactId field of the ChatContactModel object.
        var userData = await fireStore
            .collection(FirebaseRef.PROFILE_COLLECTION)
            .doc(chatContact.contactId)
            .get();
        //The fetched data is then used to create a new UserModel object.
        var profile = ChatProfile.fromMap(userData.data() ?? {});
        //Finally, a new ChatContactModel object is created by combining the information from the ChatContactModel and UserModel objects.
        // This new ChatContactModel object is added to a list of ChatContactModel objects
        messages.add(Chat(
            name: profile.userName,
            profileUrl: profile.avatar,
            lastMessage: chatContact.lastMessage,
            lastMessageTime: chatContact.lastMessageTime,
            contactId: chatContact.contactId,
            role: chatContact.role,
            ));
      }
      print('messages ${messages[0].name}');
      return messages;
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return fireStore
        .collection(FirebaseRef.USER_COLLECTION)
        //todo: change the id to the current user id
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }
}
