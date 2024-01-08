part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLogingIn;
  final bool errorLogingIn;
  final bool successLogingIn;

  final bool isRegistering;
  final bool errorRegistering;
  final bool successRegistering;

  final String? message;

  final UserModel? user;
  AuthState({
    this.isLogingIn = false,
    this.errorLogingIn = false,
    this.successLogingIn = false,
    this.isRegistering = false,
    this.errorRegistering = false,
    this.successRegistering = false,
    this.message,
    this.user,
  });

  AuthState copyWith({
    bool? isLogingIn,
    bool? errorLogingIn,
    bool? successLogingIn,
    bool? isRegistering,
    bool? errorRegistering,
    bool? successRegistering,
    String? message,
    UserModel? user,
  }) {
    return AuthState(
      isLogingIn: isLogingIn ?? this.isLogingIn,
      errorLogingIn: errorLogingIn ?? this.errorLogingIn,
      successLogingIn: successLogingIn ?? this.successLogingIn,
      isRegistering: isRegistering ?? this.isRegistering,
      errorRegistering: errorRegistering ?? this.errorRegistering,
      successRegistering: successRegistering ?? this.successRegistering,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLogingIn: $isLogingIn, errorLogingIn: $errorLogingIn, successLogingIn: $successLogingIn, isRegistering: $isRegistering, errorRegistering: $errorRegistering, successRegistering: $successRegistering, message: $message, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isLogingIn == isLogingIn &&
        other.errorLogingIn == errorLogingIn &&
        other.successLogingIn == successLogingIn &&
        other.isRegistering == isRegistering &&
        other.errorRegistering == errorRegistering &&
        other.successRegistering == successRegistering &&
        other.message == message &&
        other.user == user;
  }

  @override
  int get hashCode {
    return isLogingIn.hashCode ^
        errorLogingIn.hashCode ^
        successLogingIn.hashCode ^
        isRegistering.hashCode ^
        errorRegistering.hashCode ^
        successRegistering.hashCode ^
        message.hashCode ^
        user.hashCode;
  }
}
