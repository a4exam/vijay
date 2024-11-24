final emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
final mobileRegExp = RegExp(r'^\d{10}$');
final otpRegExp = RegExp(r'^\d{6}$');
final pinCodeRegExp = otpRegExp;

class Validator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your date of birth';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!emailRegExp.hasMatch(value)) {
      return "Email isn't valid";
    }
    return null;
  }

  /// MOBILE NUMBER
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }

    if (!mobileRegExp.hasMatch(value)) {
      return "Mobile number isn't valid";
    }
    return null;
  }

  static String? validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a item';
    }
    return null;
  }

  /// USERNAME
  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or mobile number';
    }
    if (emailRegExp.hasMatch(value)) {
      return null; // It's a valid email
    }
    if (mobileRegExp.hasMatch(value)) {
      return null; // It's a valid mobile number
    }
    return 'Please enter a valid email or mobile number';
  }

  static bool isUserNameGmail(String value) {
    if (emailRegExp.hasMatch(value)) {
      return true; // It's a valid email
    }
    return false;
  }

  /// OTP
  static String? validateOTP(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    }
    if (otpRegExp.hasMatch(value)) {
      return null; // It's a valid mobile number
    }
    return 'Please enter valid OTP';
  }

  /// PASSWORD
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter a confirm password';
    } else if (confirmPassword != password) {
      return 'confirm password is not matched';
    }
    return null;
  }

  /// GENDER
  static String? validateGender(String value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  /// EXAM PREPARATION
  static String? validateExamPreparation(String value) {
    if (value == null || value.isEmpty) {
      return 'Please select your exam preparation';
    }
    return null;
  }

  static String? validateCountry(String value) {
    if (value == null || value.isEmpty) {
      return 'Please select your country';
    }
    return null;
  }

  static String? validateState(String value) {
    if (value == null || value.isEmpty) {
      return 'Please select your state';
    }
    return null;
  }

  static String? validateDistrict(String value) {
    if (value == null || value.isEmpty) {
      return 'Please select your district';
    }
    return null;
  }

  static String? validateTownOrVillage(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your town/village';
    }
    return null;
  }

  static String? validatePinCode(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your pin-code';
    } else if (value.length > 6 || !pinCodeRegExp.hasMatch(value)) {
      return 'Please enter valid pin-code';
    }
    return null;
  }
}
