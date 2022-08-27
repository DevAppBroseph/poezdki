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
}
