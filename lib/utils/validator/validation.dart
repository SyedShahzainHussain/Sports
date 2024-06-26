class SValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is requried";
    }
    final emailregExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailregExp.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is requried";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long.";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),./";!<>]'))) {
      return "Password must contains at least one special letter.";
    }
    return null;
  }

  static String? confirmPassword(String? previousPass, String? currentPass) {
    if (currentPass == null || currentPass.isEmpty) {
      return "Confirm Password is requried";
    }
    if (previousPass != currentPass) {
      return "Password dont match";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is requried";
    }
    final phoneReg = RegExp(r'^\d{11}$');
    if (!phoneReg.hasMatch(value)) {
      return "Invalid phone number format (11 digits requried).";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is requried";
    }
    return null;
  }

  static String? cnicValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "CNIC is requried";
    }

    if (value.length != 15) {
      return "Invald CNIC number";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Address is requried";
    }
    return null;
  }

  static String? validateOrganization(String? value) {
    if (value == null || value.isEmpty) {
      return "Fields is requried";
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return "Fields is requried";
    }
    return null;
  }
}
