import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:mytrain/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String dbName = "mytrain.db";
  static const int dbVersion = 1;
  static const String usersTable = "users";

  // 1. Define a global 32-byte App Secret Key. 
  // DO NOT change this string once users start saving passwords, or you won't be able to decrypt them!
  static final encrypt.Key _appKey = encrypt.Key.fromUtf8('my32lengthsupersecretkeyno1type!');
  static final encrypt.IV _fixedIv = encrypt.IV.fromLength(16); // All zeros 16-byte IV

  void initDB() async {
    try {
      final database = await openDatabase(
        dbName,
        version: dbVersion,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              fullName TEXT,
              email TEXT,
              password TEXT
            )
          ''');
        },
      );
      print("Database initialized successfully: ${database.path}");
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  Future<void> signup(Map<String, dynamic> user) async {
    try {
      final db = await openDatabase(dbName);
      
      // Create a modifiable copy of the user map
      final Map<String, dynamic> modifiableUser = Map.from(user);
      
      // Encrypt the password before saving it to the database
      if (modifiableUser['password'] != null) {
        modifiableUser['password'] = encryptPassword(modifiableUser['password']);
      }

      await db.insert(usersTable, modifiableUser);
      print("User signed up successfully: $modifiableUser");
    } catch (e) {
      print("Error signing up user: $e");
    }
  }

  Future<User?> login(String email, String plainPassword) async {
    try {
      final db = await openDatabase(dbName);
      
      // 2. Encrypt the entered password to match how it looks in the DB
      final encryptedEnteredPassword = encryptPassword(plainPassword);

      final result = await db.query(
        usersTable,
        where: 'email = ? AND password = ?',
        whereArgs: [email, encryptedEnteredPassword],
      );

      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      } else {
        return null;
      }
    } catch (e) {
      print("Error logging in user: $e");
      return null;
    }
  }

  // Encrypts any text using the global app key
  String encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_appKey));
    final encrypted = encrypter.encrypt(password, iv: _fixedIv);
    return encrypted.base64;
  }

  // Decrypts the Base64 string back using the global app key
  String decryptPassword(String encryptedBase64) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_appKey));
    final decrypted = encrypter.decrypt64(encryptedBase64, iv: _fixedIv);
    return decrypted;
  }

  Future<bool> deleteUser(int userId) async {
    try {
      final db = await openDatabase(dbName);
      final rowsDeleted = await db.delete(
        usersTable,
        where: 'id = ?',
        whereArgs: [userId],
      );
      return rowsDeleted > 0;
    } catch (e) {
      print("Error deleting user: $e");
      return false;
    }
  }

}
