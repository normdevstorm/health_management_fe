import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseStorage get storage => _storage;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseFirestore get firestore => _firestore;
}
