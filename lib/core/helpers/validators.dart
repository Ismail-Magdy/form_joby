class Validators {
  static String? requiredField(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? url(String? value, [String? fieldName, bool required = true]) {
    if (required && (value == null || value.trim().isEmpty)) {
      return '${fieldName ?? 'URL'} is required';
    }
    if (value != null && value.trim().isNotEmpty) {
      final urlRegExp = RegExp(
          r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
      if (!urlRegExp.hasMatch(value)) {
        return 'Please enter a valid URL';
      }
    }
    return null;
  }
  
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    // Basic validation, can be enhanced based on region
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,14}$');
    if (!phoneRegExp.hasMatch(value.replaceAll(' ', ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
