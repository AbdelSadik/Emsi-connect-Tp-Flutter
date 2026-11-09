/// Fonctions de validation réutilisables (TextFormField.validator).
/// Règle : retourner null si la valeur est acceptée, sinon le message d'erreur.
class Validators {
  Validators._();

  // Vérification « pédagogique » : texte@domaine.extension, sans espace.
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // Téléphone marocain simple : 0612345678 ou +212612345678.
  static final RegExp _phoneRegex = RegExp(r'^(\+212|0)[5-7]\d{8}$');

  /// true si [email] a une forme plausible. (Ne prouve pas qu'il existe.)
  static bool isValidEmail(String email) => _emailRegex.hasMatch(email.trim());

  static String? email(String? value) {
    final email = (value ?? '').trim();
    if (email.isEmpty) return 'Email obligatoire';
    if (!isValidEmail(email)) return 'Email invalide';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe obligatoire';
    if (value.length < 8) return 'Au moins 8 caractères';
    return null;
  }

  static String? confirmation(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirmez votre mot de passe';
    if (value != password) return 'Les mots de passe ne correspondent pas';
    return null;
  }

  static String? fullName(String? value) {
    final name = (value ?? '').trim();
    if (name.isEmpty) return 'Nom complet obligatoire';
    if (name.length < 3) return 'Au moins 3 caractères';
    return null;
  }

  /// Champ facultatif : vide = accepté, sinon le format doit être correct.
  static String? optionalPhone(String? value) {
    final phone = (value ?? '').replaceAll(' ', '');
    if (phone.isEmpty) return null;
    if (!_phoneRegex.hasMatch(phone)) {
      return 'Numéro invalide (ex. 0612345678)';
    }
    return null;
  }
}
