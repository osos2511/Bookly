/// Firebase rejects passwords shorter than this, so the form catches it first.
const int kMinPasswordLength = 6;

final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

class Validators {
  const Validators._();

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email';
    if (!_emailRegExp.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Please enter your password';
    if (password.length < kMinPasswordLength) {
      return 'Password must be at least $kMinPasswordLength characters';
    }
    return null;
  }
}
