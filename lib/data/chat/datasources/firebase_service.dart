import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseAuth get auth => _auth;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseStorage get storage => _storage;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseFirestore get firestore => _firestore;
  static final FirebaseDatabase _database = FirebaseDatabase.instance;
  static FirebaseDatabase get database => _database;
}
