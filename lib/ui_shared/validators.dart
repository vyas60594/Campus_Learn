class Validators {
  // Returns error message or null if valid
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter your email';
    final basicEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!basicEmail.hasMatch(text))
      return 'Enter a valid email (e.g. name@mail.com)';
    return null;
  }

  static String? password(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter a password';
    if (text.length < 6) return 'Use at least 6 characters';
    return null;
  }
}

