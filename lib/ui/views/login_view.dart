import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../providers/auth_provider.dart';
import '../../providers/login_form_provider.dart';
import '../../router/router.dart';
import '../buttons/custom_outlined_btn.dart';
import '../buttons/link_text.dart';
import '../inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);
          return Container(
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
                              label: 'Email',
                              icon: Icons.email_outlined),
                          onChanged: (value) => loginFormProvider.email = value,
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? '')) return 'Email no válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '********',
                              label: 'Password',
                              icon: Icons.lock_outline),
                          onChanged: (value) =>
                              loginFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Coloque su contraseña';
                            if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomOutlinedBtn(
                          onPressed: () {
                            final isValid = loginFormProvider.validateForm();
                            if (isValid) authProvider.login(loginFormProvider.email, loginFormProvider.password);
                          },
                          text: 'Ingresar',
                        ),
                        const SizedBox(height: 20),
                        LinkText(
                          text: 'Registro',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Flurorouter.registerRoute);
                          },
                        )
                      ],
                    )),
              ),
            ),
          );
        }));
  }
}