import 'package:get/get.dart';

String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Enter username.';
  }
  if (!GetUtils.isAlphabetOnly(value.trim())) {
    return 'Enter a valid username.';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your name.';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your email address.';
  }
  if (!GetUtils.isEmail(value)) {
    return 'Enter a valid email address.';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your phone number.';
  }
  if (!GetUtils.isPhoneNumber(value)) {
    return 'Enter a valid phone number.';
  }
  return null;
}

String? validateEditCurrentPassword(String? value, String currentPassword) {
  if (currentPassword.isNotEmpty &&
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{6,}$')
          .hasMatch(currentPassword)) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }
  return null;
}

String? validateEditConfirmPassword(
    String? value, String currentPassword, String newPassword) {
  if (currentPassword.isNotEmpty &&
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{6,}$')
          .hasMatch(currentPassword)) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (newPassword != value) {
      return 'Passwords do not match.';
    }
    return null;
  }
  return null;
}

String? validateIsEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required.';
  }
  return null;
}

String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter description.';
  }
  return null;
}

String? validateNumeric(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required.';
  }
  if (!GetUtils.isNumericOnly(value)) {
    return 'Please enter numeric data.';
  }
  return null;
}

String? isPasswordValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your password.';
  } else if (value.length < 6) {
    return 'Password should be greater than 6.';
  }
  return null;
}

String? isNewPasswordValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your new password.';
  } else if (value.length < 6) {
    return 'Password should be greater than 6.';
  }
  return null;
}

String? isConfirmPasswordValid(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Enter confirm password.';
  } else if (value.length < 6) {
    return 'Password should be greater than 6.';
  } else if (value != password) {
    return 'Password does not match!';
  }
  return null;
}

String? isCvvValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter cvv.';
  } else if (value.length != 3) {
    return 'Enter valid cvv.';
  } else {
    return null;
  }
}

String? isCardValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter card name.';
  }
  return null;
}

String? isExpiryValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter expiry date';
  }

  // Regex: MM-YYYY
  final regex = RegExp(r'^(0[1-9]|1[0-2])-(\d{4})$');
  if (!regex.hasMatch(value)) {
    return 'Enter in MM-YYYY format';
  }

  final parts = value.split('-');
  final month = int.parse(parts[0]);
  final year = int.parse(parts[1]);

  final now = DateTime.now();
  final expiryDate = DateTime(year, month);

  if (expiryDate.isBefore(DateTime(now.year, now.month))) {
    return 'Card has expired';
  }

  return null;
}

String? isCardNameValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter card number.';
  } else if (value.length != 16) {
    return 'Enter valid card number of 16 digits.';
  } else {
    return null;
  }
}

String? isPostalValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter postal.';
  }
  return null;
}

String? isDateValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Select date.';
  }
  return null;
}

String? isTimeValid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Select time.';
  }
  return null;
}
