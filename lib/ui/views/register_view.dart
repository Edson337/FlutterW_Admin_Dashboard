import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../providers/auth_provider.dart';
import '../../providers/register_form_provider.dart';
import '../../router/router.dart';
import '../buttons/custom_outlined_btn.dart';
import '../buttons/link_text.dart';
import '../inputs/custom_inputs.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _isObscure = true;
  bool get isObscure => _isObscure;
  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
        return ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su nombre',
                          label: 'Nombre',
                          icon: Icons.person
                        ),
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su correo',
                          label: 'Correo Electrónico',
                          icon: Icons.email_outlined
                        ),
                        onChanged: (value) => registerFormProvider.email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'El correo electrónico es obligatorio';
                          if (!EmailValidator.validate(value)) return 'Correo electrónico no válido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Consumer<PasswordVisibilityProvider>(
                        builder: (context, visibilityProvider, child) {
                          return TextFormField(
                            obscureText: visibilityProvider.isObscure,
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.passwordInputDecoration(
                              hint: '********',
                              label: 'Contraseña',
                              isObscure: visibilityProvider.isObscure,
                              toggleVisibility: visibilityProvider.toggleVisibility
                            ),
                            onChanged: (value) => registerFormProvider.password = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
                              if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedBtn(
                        onPressed: () {
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return;
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          authProvider.register(registerFormProvider.name, registerFormProvider.email, registerFormProvider.password);
                        },
                        text: 'Crear cuenta',
                      ),
                      const SizedBox(height: 20),
                      LinkText(
                        text: 'Inicio de Sesión',
                        onPressed: () => Navigator.pushNamed(context, Flurorouter.loginRoute)
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}