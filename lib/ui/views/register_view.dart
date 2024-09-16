import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../buttons/custom_outlined_btn.dart';
import '../buttons/link_text.dart';
import '../inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Coloque su nombre',
                        label: 'Nombre',
                        icon: Icons.person
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Coloque su correo',
                        label: 'Email',
                        icon: Icons.email_outlined
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.loginInputDecoration(
                        hint: '********',
                        label: 'Password',
                        icon: Icons.lock_outline
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomOutlinedBtn(
                    onPressed: (){},
                    text: 'Crear cuenta',
                  ),
                  const SizedBox(height: 20),
                  LinkText(
                    text: 'Inicio de Sesión',
                    onPressed: (){
                      Navigator.pushNamed(context, Flurorouter.loginRoute);
                    },
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}