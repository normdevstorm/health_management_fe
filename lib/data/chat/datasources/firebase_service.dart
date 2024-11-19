import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseApp _chatApp = Firebase.app('chatApp');

  static final FirebaseAuth _auth = FirebaseAuth.instanceFor(app: _chatApp);
  static FirebaseAuth get auth => _auth;
  static final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(app: _chatApp);
  static FirebaseStorage get storage => _storage;
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instanceFor(app: _chatApp);
  static FirebaseFirestore get firestore => _firestore;
  static final FirebaseDatabase _database =
      FirebaseDatabase.instanceFor(app: _chatApp);
  static FirebaseDatabase get database => _database;
}
