enum ProfileStatus {
  initial,
  loading,
  success,
  passwordResetSent,
  loggedOut,
  error,
}

class ProfileState {
  final ProfileStatus status;
  final String        name;
  final String        email;
  final String        avatarInitial;
  final String?       errorMessage;
  final bool          notificationsEnabled;

  const ProfileState({
    this.status        = ProfileStatus.initial,
    this.name          = '',
    this.email         = '',
    this.avatarInitial = '?',
    this.errorMessage,
    this.notificationsEnabled = false,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String?        name,
    String?        email,
    String?        avatarInitial,
    String?        errorMessage,
    bool?          notificationsEnabled,
  }) {
    return ProfileState(
      status:        status        ?? this.status,
      name:          name          ?? this.name,
      email:         email         ?? this.email,
      avatarInitial: avatarInitial ?? this.avatarInitial,
      errorMessage:  errorMessage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}