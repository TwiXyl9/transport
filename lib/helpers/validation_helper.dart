extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*[A-ЯЁ][а-яё]+\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this != null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^(\+375|80)(29|25|44|33)(\d{3})(\d{2})(\d{2})$");
    return phoneRegExp.hasMatch(this);
  }

}