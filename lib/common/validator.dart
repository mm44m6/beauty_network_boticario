abstract class ValidatorInterface {
  bool isEmailValid(String email);
}

class Validator implements ValidatorInterface {
  bool isEmailValid(String email) {
    Pattern _emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(_emailPattern);

    if (regex.hasMatch(email)) return true;
    return false;
  }
}
