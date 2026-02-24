import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/features/authentication/data/models/user_model.dart';

class AuthDataSource {
  final FirebaseAuth _auth;
  final SharedPreferences _prefs;

  AuthDataSource(this._auth, this._prefs);

  // ── Keys ─────────────────────────────────────────────────────────────────
  static const String _emailKey         = 'user_email';
  static const String _nameKey          = 'user_name';
  static const String _avatarInitialKey = 'user_avatar_initial';
  static const String _createdAtKey     = 'user_created_at';

  // ── User Storage ──────────────────────────────────────────────────────────
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_emailKey,         user.email);
    await _prefs.setString(_nameKey,          user.name);
    await _prefs.setString(_avatarInitialKey, user.avatarInitial);
    await _prefs.setInt(_createdAtKey,        user.createdAt.millisecondsSinceEpoch);
  }

  UserModel? getUser() {
    final email = _prefs.getString(_emailKey);
    if (email == null) return null;

    return UserModel(
      email:         email,
      name:          _prefs.getString(_nameKey)          ?? '',
      avatarInitial: _prefs.getString(_avatarInitialKey) ?? '?',
      createdAt:     DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt(_createdAtKey) ?? 0,
      ),
    );
  }

  Future<void> deleteUser() async {
    await _prefs.remove(_emailKey);
    await _prefs.remove(_nameKey);
    await _prefs.remove(_avatarInitialKey);
    await _prefs.remove(_createdAtKey);
  }

  bool get hasUser => _prefs.containsKey(_emailKey);

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result;
  }

  Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result;
  }

}
