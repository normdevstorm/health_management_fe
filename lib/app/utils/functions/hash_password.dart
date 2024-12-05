import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password, {String algorithm = 'sha256'}) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes); // Use sha1 for SHA-1 hashing
  return digest.toString();
}

bool comparePassword(String password, String hashedPassword) {
  var hashedInput = hashPassword(password);
  return hashedInput == hashedPassword;
}
