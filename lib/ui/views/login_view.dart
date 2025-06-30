import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/ui.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
        return ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: loginFormProvider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su correo',
                          label: 'Correo Electrónico',
                          icon: Icons.email_outlined),
                        onChanged: (value) => loginFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? '')) return 'Email no válido';
                          return null;
                        },
                        onFieldSubmitted: (_) => onformSubmit(loginFormProvider, authProvider),
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
                            onChanged: (value) => loginFormProvider.password = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Coloque su contraseña';
                              if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                              return null;
                            },
                            onFieldSubmitted: (_) => onformSubmit(loginFormProvider, authProvider),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedBtn(
                        onPressed: () => onformSubmit(loginFormProvider, authProvider),
                        text: 'Ingresar',
                      ),
                      const SizedBox(height: 20),
                      LinkText(
                        text: 'Registro',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Flurorouter.registerRoute);
                        },
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        );
      })
    );
  }

  void onformSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) authProvider.login(loginFormProvider.email, loginFormProvider.password);
  }
}