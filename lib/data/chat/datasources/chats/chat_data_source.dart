import 'dart:io';

import 'package:health_management/app/utils/constants/firebase_ref.dart';
import 'package:health_management/app/utils/enums/message_type.dart';
import 'package:health_management/app/utils/errors/exception.dart';

import 'package:health_management/data/chat/datasources/firebase_service.dart';
import 'package:health_management/domain/chat/models/chat_model.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:health_management/domain/chat/models/message_reply_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class ChatRemoteDataSource {
  Stream<List<Message>> getChatStream(String receiverId);
  Stream<List<Message>> getGroupChatStream(String groupId);

  Future<void> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<void> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<void> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<void> setMessageSeen(String receiverId, String messageId);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final fireStore = FirebaseService.firestore;
  final auth = FirebaseService.auth;
  final firebaseStorage = FirebaseService.storage;

  ChatRemoteDataSourceImpl();

  Future<UserChatModel> _getCurrentUser() async {
    var userCollection =
        await fireStore.collection("users").doc(auth.currentUser!.uid).get();
    UserChatModel user = UserChatModel.fromMap(userCollection.data()!);
    return user;
  }

  // The method uses Firebase Firestore to retrieve messages from a chat between the current user (identified by their user ID) and another user identified by receiverId.
  @override
  Stream<List<Message>> getChatStream(String receiverId) {
    //todo: change the id to the current user id

    //The method first gets a reference to the Firestore database and constructs a query to fetch messages from the current user's chat with the given receiverId.
    return fireStore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        //The orderBy method is used to sort the messages by the timeSent field in ascending order.
        .orderBy('timeSent')
        //The snapshots method returns a stream of QuerySnapshots that contain the results of the query.
        .snapshots()
        .map((event) {
      //The map function loops over each document in the QuerySnapshot and converts the document data into a MessageModel object using the fromMap
      // method of the MessageModel class.
      List<Message> messages = [];
      for (var document in event.docs) {
        //The resulting MessageModel objects are then added to a list and returned as the result of the map function.
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Stream<List<Message>> getGroupChatStream(String groupId) {
    return fireStore
        .collection('groups')
        .doc(groupId)
        .collection('chats')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  // The sendTextMessage method is a function that sends a text message from the current user to a receiver user in a chat application.
  @override
  Future<void> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat,
      }) async {
    try {
      //It gets the current time when the message is sent using DateTime.now()
      var timeSent = DateTime.now();
      // generates a unique message ID using Uuid().v1().
      var messageId = const Uuid().v1();
      UserChatModel? receiverUserData;
      //Retrieves the current user's data using the _getCurrentUser() method.
      UserChatModel senderUserData = await _getCurrentUser();

      if (!isGroupChat) {
        var receiverUserCollection =
            await fireStore.collection("users").doc(receiverId).get();
        receiverUserData =
            UserChatModel.fromMap(receiverUserCollection.data()!);
      }

      //It calls the _saveDataToContactsSubCollection method to save the message data to both the sender and receiver's chat collections,
      // which includes their names, profile pictures, user IDs, the text of the last message, and the time it was sent.
      _saveDataToContactsSubCollection(receiverId, senderUserData,
          receiverUserData, text, timeSent, isGroupChat, );
      //calls the _saveMessageToMessageSubCollection method to save the message in a sub-collection called messages under both the sender and
      // receiver's chat collections, which allows users to view their chat history and maintain a record of their conversations.
      // It includes the sender's and receiver's IDs, the text of the message, the type of message (in this case, text), and more
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uid,
          receiverId: receiverId,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.text,
          receiverUsername: receiverUserData?.userName,
          senderUsername: senderUserData.userName,
          messageReply: messageReply,
          isGroupChat: isGroupChat,

          );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // The sendGIFMessage method is a function that sends a GIF message from the current user to a receiver user in a chat application.
  @override
  Future<void> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      UserChatModel senderUserData = await _getCurrentUser();

      UserChatModel? receiverUserData;
      if (!isGroupChat) {
        var receiverUserCollection =
            await fireStore.collection("users").doc(receiverId).get();
        receiverUserData =
            UserChatModel.fromMap(receiverUserCollection.data()!);
      }

      _saveDataToContactsSubCollection(receiverId, senderUserData,
          receiverUserData, "GIF", timeSent, isGroupChat);
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uid,
          receiverId: receiverId,
          text: gifUrl,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageType.gif,
          receiverUsername: receiverUserData?.userName,
          senderUsername: senderUserData.userName,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //this _saveDataToContactsSubCollection function to save the message data to both sender and receiver's chat collections. and show it in contact chat page
  void _saveDataToContactsSubCollection(
      String receiverId,
      UserChatModel senderUserData,
      UserChatModel? receiverUserData,
      String text,
      DateTime timeSent,
      bool isGroupChat) async {
    if (isGroupChat) {
      await fireStore.collection("groups").doc(receiverId).update({
        'lastMessage': text,
        'timeSent': DateTime.now().millisecondsSinceEpoch
      });
    } else {
      //The _saveDataToContactsSubCollection function creates two ChatContact objects to store the message data for both the sender and receiver.
      // It includes the sender's name, profile picture, user ID, the text of the last message, and the time it was sent.
      // users -> current user id  => chats -> receiver user id -> set data
      var receiverChatContact = Chat(
          name: senderUserData.userName,
          profileUrl: senderUserData.profileImage,
          contactId: senderUserData.uid,
          lastMessage: text,
          lastMessageTime: timeSent,
          role: senderUserData.role
          );
      await fireStore
          .collection("users")
          .doc(receiverUserData!.uid)
          .collection("chats")
          .doc(senderUserData.uid)
          .set(receiverChatContact.toMap());

      // users -> receiver user id  => chats -> current user id  -> set data
      var senderChatContact = Chat(
          name: receiverUserData.userName,
          profileUrl: receiverUserData.profileImage,
          contactId: receiverUserData.uid,
          lastMessage: text,
          lastMessageTime: timeSent,
          role: receiverUserData.role
          );
      await fireStore
          .collection("users")
          .doc(senderUserData.uid)
          .collection("chats")
          .doc(receiverUserData.uid)
          .set(senderChatContact.toMap());
    }
  }

  // the _saveMessageToMessageSubCollection method is to save a message sent by one user to another user in a sub-collection called messages and
  // allows users to view their chat history and maintain a record of their conversations.
  void _saveMessageToMessageSubCollection(
      {required String senderId,
      required String receiverId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String? receiverUsername,
      required String senderUsername,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat
      }) async {
    //The _saveMessageToMessageSubCollection method then stores this MessageModel object in two locations in the Firestore database.
    final message = Message(
      senderId: senderId,
      receiverId: receiverId,
      content: text,
      messageType: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      senderName: senderUsername,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : messageReply.repliedTo,
      repliedMessageType:
          messageReply == null ? MessageType.text : messageReply.messageType,
    );

    if (isGroupChat) {
      // groups -> group id -> chat -> message
      await fireStore
          .collection('groups')
          .doc(receiverId)
          .collection('chats')
          .doc(messageId)
          .set(message.toMap());
    } else {
      // user -> user id -> receiver id -> messages -> messages id -> store message
      //The first location is under the sender's user ID, in a chats collection, which contains a document for the receiver's user ID, which, in turn, contains a messages collection
      await fireStore
          .collection("users")
          .doc(senderId)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .doc(messageId)
          .set(message.toMap());

      // user -> receiver id ->  user id -> messages -> messages id -> store message
      //The second location is under the receiver's user ID, in a chats collection, which contains a document for the sender's user ID, which, in turn, contains a messages collection.
      await fireStore
          .collection("users")
          .doc(receiverId)
          .collection("chats")
          .doc(senderId)
          .collection("messages")
          .doc(messageId)
          .set(message.toMap());
    }
  }

  //The sendFileMessage method is used to send a file message from one user to another in a chat application.
  @override
  Future<void> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      //It gets the current date and time when the message is sent
      var timeSent = DateTime.now();
      //generates a unique message ID
      var messageId = const Uuid().v1();
      //It retrieves the sender user's data by calling the _getCurrentUser() method.
      UserChatModel senderUserData = await _getCurrentUser();

      UserChatModel? receiverUserData;
      if (!isGroupChat) {
        var receiverUserCollection =
            await fireStore.collection("users").doc(receiverId).get();
        receiverUserData =
            UserChatModel.fromMap(receiverUserCollection.data()!);
      }

      //Stores the file to Firebase Storage using the _storeFileToFirebase() method, which uploads the file to Firebase Storage and
      // returns the download URL of the uploaded file.

      var fileUrl = await _storeFileToFirebase(
        'chat/${messageType.type}/${senderUserData.uid}/$receiverId/$messageId',
        file,
      );

      String contactMessage;
      switch (messageType) {
        case MessageType.image:
          contactMessage = '📷 Photo';
          break;
        case MessageType.video:
          contactMessage = '🎥 Video';
          break;
        case MessageType.audio:
          contactMessage = '🎙️ Audio';
          break;
        case MessageType.gif:
          contactMessage = '🎬 Gif';
          break;
        case MessageType.file:
          contactMessage = '📁 File';
          break;
        default:
          contactMessage = 'Other';
      }

      //this only show in contact chat, and show in the last text message like String photo and etc.
      //Saves the contact message data to both the sender and receiver's chat collections in the Firestore database using the _saveDataToContactsSubCollection() method.
      _saveDataToContactsSubCollection(receiverId, senderUserData,
          receiverUserData, contactMessage, timeSent, isGroupChat);

      //Saves the message data to the sender's and receiver's message sub-collections in the Firestore database using the _saveMessageToMessageSubCollection() method.
      // This includes the sender ID, receiver ID, text of the message (which is the download URL of the uploaded file), message type, and more
      _saveMessageToMessageSubCollection(
          senderId: senderUserData.uid,
          receiverId: receiverId,
          text: fileUrl,
          timeSent: timeSent,
          messageId: messageId,
          receiverUsername: receiverUserData?.userName,
          senderUsername: senderUserData.userName,
          messageType: messageType,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    String downloadUrl = '';
    try {
      //First, the method creates an UploadTask object using the putFile method of the Firebase Storage reference. The path parameter is used as
      // the path of the file in Firebase Storage, and the file parameter is used as the actual file to be uploaded
      UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
      //Next, the method waits for the upload to complete by awaiting the UploadTask object. The result of the upload is a TaskSnapshot object,
      // which contains information about the uploaded file, such as its download URL.
      TaskSnapshot snapshot = await uploadTask;
      //Finally, the method gets the download URL of the uploaded file by calling the getDownloadURL method on the TaskSnapshot object, and returns it as a String.
      downloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw ServerException(e.toString());
    }
    print('Download URL: $downloadUrl');
    return downloadUrl;
  }

  //The function for marking a message as seen
  //Inside the function, there are two update operations being performed using await on two different documents in Firestore.
  @override
  Future<void> setMessageSeen(String receiverId, String messageId) async {
    try {
      // The first update operation marks the message as seen in the sender's chat,
      // The isSeen field is updated to true in both cases, indicating that the message has been seen.
      await fireStore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .doc(messageId)
          .update({'isSeen': true});

      // while the second update operation marks the same message as seen in the receiver's chat.
      await fireStore
          .collection("users")
          .doc(receiverId)
          .collection("chats")
          .doc(auth.currentUser!.uid)
          .collection("messages")
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
