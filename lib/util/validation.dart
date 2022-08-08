
class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return '';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Используйте только буквы.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) return 'Введите действующий email';
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