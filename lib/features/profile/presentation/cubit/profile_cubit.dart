import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/core/networking/notification_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SharedPreferences _prefs;
  final FirebaseAuth      _auth;

  ProfileCubit(this._prefs, this._auth) : super(const ProfileState());

  static ProfileCubit get(BuildContext context) =>
      context.read<ProfileCubit>();

  // ── Load user data ────────────────────────────────────────────────────────
  void loadProfile() {
    emit(state.copyWith(status: ProfileStatus.loading));

    final email       = _prefs.getString('user_email') ?? '';
    final savedName   = _prefs.getString('user_name')  ?? '';
    final displayName = savedName.isNotEmpty ? savedName : 'User';
    final initial     = displayName[0].toUpperCase();

    emit(state.copyWith(
      status:        ProfileStatus.success,
      name:          displayName,
      email:         email,
      avatarInitial: initial,
    ));
  }

  void toggleNotifications(bool enabled) async {
    await _prefs.setBool('notifications_enabled', enabled);

    emit(state.copyWith(
      notificationsEnabled: enabled,
    ));

    if (!enabled) {
      // user disabled notifications, nothing else to do
      debugPrint('Notifications disabled by user');
      return;
    }

    // When enabling: check and request permission
    final granted = await NotificationService.requestPermission();
    if (granted) {
      // send a test notification to confirm
      await NotificationService.showNotification();
      debugPrint('Notification permission granted, test notification shown');
    } else {
      debugPrint('Notification permission denied');
      // If permission denied, guide user to app settings
      await NotificationService.showPermissionDialog();
    }

    print('Notifications ${enabled ? 'enabled' : 'disabled'}');
  }


  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await _auth.signOut();
    await _prefs.setBool('is_logged_in', false);
    emit(state.copyWith(status: ProfileStatus.loggedOut));
  }
}