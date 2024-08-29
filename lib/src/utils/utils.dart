class AppValidators {
  static String? validateName(String? value) {
    if (value == null || value.length < 3) {
      return 'Veuillez entrer un nom valide';
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }

  static String? validateOptionalEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }
}
