import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {

  static String handleError(Object e) {
    // Firebase Auth
    if (e is FirebaseAuthException) {
      return handleFirebaseAuthError(e);
    }

    // Firestore / Firebase
    if (e is FirebaseException) {
      return handleFirestoreError(e);
    }

    // Network
    if (e is SocketException) {
      return 'No internet connection. Please check your network.';
    }
    if (e is TimeoutException) {
      return 'Request timed out. Please try again.';
    }
    if (e is HttpException) {
      return 'Network error occurred. Please try again.';
    }

    // Format Exception (parsing errors)
    if (e is FormatException) {
      return 'Invalid data format received.';
    }

    // Generic Exception
    if (e is Exception) {
      return 'An error occurred: ${e.toString().replaceAll('Exception: ', '')}';
    }

    // Fallback
    return 'An unexpected error occurred. Please try again.';
  }


  /// Handles Firebase Authentication errors.
  static String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      // Sign In Errors
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';

      // Sign Up Errors
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak. Use at least 8 characters.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';

      // Rate Limiting
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      // Network
      case 'network-request-failed':
        return 'Network error. Please check your connection.';

      // Session / Token
      case 'requires-recent-login':
        return 'Please sign in again to continue.';
      case 'session-expired':
        return 'Your session has expired. Please sign in again.';
      case 'user-token-expired':
        return 'Your session has expired. Please sign in again.';

      // Email Actions
      case 'expired-action-code':
        return 'This link has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'This link is invalid. Please request a new one.';

      // Other
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';

      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }


  /// Handles Firestore and general Firebase errors.
  static String handleFirestoreError(FirebaseException e) {
    switch (e.code) {
      // Permission
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unauthenticated':
        return 'Please sign in to continue.';

      // Not Found
      case 'not-found':
        return 'The requested data was not found.';

      // Network / Availability
      case 'unavailable':
        return 'Service temporarily unavailable. Please try again.';
      case 'deadline-exceeded':
        return 'Request timed out. Please try again.';

      // Data Conflicts
      case 'already-exists':
        return 'This item already exists.';
      case 'aborted':
        return 'Operation was aborted. Please try again.';
      case 'failed-precondition':
        return 'Operation failed. Please try again.';

      // Data Issues
      case 'invalid-argument':
        return 'Invalid data provided.';
      case 'data-loss':
        return 'Data loss occurred. Please contact support.';
      case 'out-of-range':
        return 'Value is out of allowed range.';

      // Resource
      case 'resource-exhausted':
        return 'Too many requests. Please try again later.';
      case 'cancelled':
        return 'Operation was cancelled.';

      // Internal
      case 'internal':
        return 'An internal error occurred. Please try again.';
      case 'unimplemented':
        return 'This feature is not available.';
      case 'unknown':
        return 'An unknown error occurred. Please try again.';

      default:
        return e.message ?? 'A database error occurred. Please try again.';
    }
  }


  // ─────────────────────────────────────────────────────────────────────────
  // NETWORK ERRORS
  // ─────────────────────────────────────────────────────────────────────────

  /// Handles network-related errors.
  static String handleNetworkError(Object e) {
    if (e is SocketException) {
      return 'No internet connection. Please check your network.';
    }
    if (e is TimeoutException) {
      return 'Request timed out. Please try again.';
    }
    if (e is HttpException) {
      return 'Network error occurred. Please try again.';
    }
    return 'A network error occurred. Please check your connection.';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // VALIDATION ERRORS
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns validation error messages.
  static String validationError(String field) {
    return 'Please enter a valid $field.';
  }

  /// Returns required field error message.
  static String requiredField(String field) {
    return '$field is required.';
  }
}

