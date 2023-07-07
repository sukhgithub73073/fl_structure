String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is Required";
  }
  if (!(RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value))) {
    return "Please Enter Valid Email";
  }
  return null;
}

String? customValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName is Required";
  } else {
    return null;
  }
}

String? pinValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Pin number is Required";
  } else if (value.length < 4) {
    return "Pin number length is 4 character required";
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is Required";
  } else if (value.length < 6) {
    return "Password minimum length 6 character required";
  } else if (value.length > 15) {
    return "Password maximum length 15 character";
  } else {
    return null;
  }
}

String? confPasswordValidator(String? value, String pass) {
  if (value == null || value.isEmpty) {
    return "Confirm password is Required";
  } else if (value != pass) {
    return "confirm password is not matched";
  } else {
    return null;
  }
}

String? mobileNumberValidator(String? value, String title) {
  if (value == null || value.isEmpty) {
    return "$title is Required";
  } else if (value.length < 10) {
    return '$title must be minimum 10 digits';
  } else if (value.length > 14) {
    return '$title must be maximum 14 digits';
  } else {
    return null;
  }
}
