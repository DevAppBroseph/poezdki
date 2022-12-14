class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'Укажите имя.';
    return null;
  }

  static String? validateSurname(String? value) {
    if (value!.isEmpty) return 'Укажите фамилию.';
    return null;
  }

  static String? validateGender(String? value) {
    if (value!.isEmpty) return 'Укажите пол.';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) return 'Укажите номер телефона.';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 8) {
      return 'Слабый пароль. Пароль должен состоять из: минимум 8 символов на латинице и цифры.';
    }
    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым.';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    final alphanumeric = RegExp(r'[А-Я]{1}[0-9]{3}[А-Я]{2}[0-9]{2,3}');
    if (!alphanumeric.hasMatch(value!)) {
      return 'Неверный формат. С777СС799';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final alphanumeric = RegExp(r'[0-9]{10}');
    if (!alphanumeric.hasMatch(value!)) {
      return 'Неверный формат.';
    }
    return null;
  }

  static String? validateYear(String? value) {
    final alphanumeric = RegExp(r'[0-9]{4}');
    if (!alphanumeric.hasMatch(value!)) {
      return 'Неверный формат.';
    }
    if (int.parse(value) < 1980  || int.parse(value) > DateTime.now().year) {
      return 'Год не может быть меньше 1980 и больше ${DateTime.now().year}.';
    }
    return null;
  }

  static String? validateDateBirthday(String? value) {
    final alphanumeric = RegExp(r'[0-9]{2}.[0-9]{2}.[0-9]{4}');
    if (!alphanumeric.hasMatch(value!)) {
      return 'Неверный формат.';
    }
    String year = '';
    for (int i = 6; i <= 9; i++) {
      year += value[i];
    }
    int? yearInt = int.tryParse(year);
    if(yearInt == null) {
      return 'Введите год.';
    }
    if (yearInt < DateTime.now().year - 100 || yearInt > DateTime.now().year) {
      return 'Год не может быть меньше ${DateTime.now().year - 100} и больше ${DateTime.now().year}.';
    }
    return null;
  }
}
