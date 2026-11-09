import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/validators.dart';
import '../widgets/theme_toggle_button.dart';

/// Écran d'inscription (TP4) : 4 champs + 2 champs bonus facultatifs.
/// Contrôles LOCAUX uniquement : aucun compte n'est créé.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _phoneController = TextEditingController(); // bonus
  final _descriptionController = TextEditingController(); // bonus

  bool _showPassword = false;
  bool _showConfirm = false;
  AutovalidateMode _autoMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Formulaire valide — compte non créé')),
        );
    } else {
      setState(() => _autoMode = AutovalidateMode.onUserInteraction);
    }
  }

  /// Bouton œil réutilisé par les deux champs de mot de passe.
  Widget _eyeButton({required bool visible, required VoidCallback onPressed}) {
    return IconButton(
      tooltip: visible ? 'Masquer le mot de passe' : 'Afficher le mot de passe',
      icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Créez votre compte EMSI Connect',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ---- Nom complet
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nom complet',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: Validators.fullName,
                    ),
                    const SizedBox(height: 16),

                    // ---- Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Adresse email',
                        hintText: 'exemple@emsi.ma',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),

                    // ---- Mot de passe
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: _eyeButton(
                          visible: _showPassword,
                          onPressed: () =>
                              setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 16),

                    // ---- Confirmation
                    TextFormField(
                      controller: _confirmController,
                      obscureText: !_showConfirm,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        prefixIcon: const Icon(Icons.lock_reset),
                        suffixIcon: _eyeButton(
                          visible: _showConfirm,
                          onPressed: () =>
                              setState(() => _showConfirm = !_showConfirm),
                        ),
                      ),
                      validator: (value) => Validators.confirmation(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ---- Bonus : téléphone (clavier numérique)
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Téléphone (facultatif)',
                        hintText: '0612345678',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: Validators.optionalPhone,
                    ),
                    const SizedBox(height: 16),

                    // ---- Bonus : description avec compteur de caractères
                    // (maxLength affiche automatiquement « 0/200 »).
                    TextFormField(
                      controller: _descriptionController,
                      maxLength: 200,
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        labelText: 'Description (facultatif)',
                        alignLabelWithHint: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Icon(Icons.notes),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Créer mon compte'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      child: const Text('Déjà un compte ? Se connecter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
