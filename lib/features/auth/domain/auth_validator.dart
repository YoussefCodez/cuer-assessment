import 'package:injectable/injectable.dart';
import 'package:cure/config/utils/auth_regx.dart';

/// Domain-level validation for authentication operations.
@injectable
class AuthValidator {
  const AuthValidator();

  /// Validates [email] format and [password] length.
  /// Throws [ArgumentError] if invalid.
  void validateCredentials(String email, String password) {
    if (email.isEmpty || !AuthRegx.isValidEmail(email)) {
      throw ArgumentError('Invalid email format');
    }
    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }
  }
}
