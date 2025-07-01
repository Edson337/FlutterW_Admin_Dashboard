import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart'; // Validador de emails

import 'package:admin_dashboard/providers/providers.dart'; // Proveedores de estado
import 'package:admin_dashboard/router/router.dart'; // Rutas de navegación
import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider para manejar la autenticación del usuario
    final authProvider = Provider.of<AuthProvider>(context);

    // Configuración de múltiples providers anidados para el formulario de login
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(), // Provider para manejar el estado del formulario
      child: Builder(builder: (context) {
        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
        return ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(), // Provider para alternar visibilidad de contraseña
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370), // Limita el ancho máximo del formulario
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus, // Valida automáticamente cuando el campo pierde el foco
                  key: loginFormProvider.formKey, // Clave del formulario para validaciones
                  child: Column(
                    children: [
                      // CAMPO DE EMAIL CON VALIDACIÓN
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su correo',
                          label: 'Correo Electrónico',
                          icon: Icons.email_outlined),
                        onChanged: (value) => loginFormProvider.email = value, // Actualiza el email en el provider
                        validator: (value) {
                          // Validación usando EmailValidator para formato correcto
                          if (!EmailValidator.validate(value ?? '')) return 'Email no válido';
                          return null;
                        },
                        onFieldSubmitted: (_) => onformSubmit(loginFormProvider, authProvider), // Submit al presionar Enter
                      ),
                      const SizedBox(height: 20),
                      // CAMPO DE CONTRASEÑA CON FUNCIONALIDAD DE MOSTRAR/OCULTAR
                      Consumer<PasswordVisibilityProvider>(
                        builder: (context, visibilityProvider, child) {
                          return TextFormField(
                            obscureText: visibilityProvider.isObscure, // Controla si el texto se muestra u oculta
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.passwordInputDecoration(
                              hint: '********',
                              label: 'Contraseña',
                              isObscure: visibilityProvider.isObscure,
                              toggleVisibility: visibilityProvider.toggleVisibility // Función para alternar visibilidad
                            ),
                            onChanged: (value) => loginFormProvider.password = value, // Actualiza la contraseña en el provider
                            validator: (value) {
                              // Validaciones de contraseña
                              if (value == null || value.isEmpty) return 'Coloque su contraseña';
                              if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                              return null;
                            },
                            onFieldSubmitted: (_) => onformSubmit(loginFormProvider, authProvider), // Submit al presionar Enter
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // BOTÓN PRINCIPAL DE ENVÍO DEL FORMULARIO
                      CustomOutlinedBtn(
                        onPressed: () => onformSubmit(loginFormProvider, authProvider),
                        text: 'Ingresar',
                      ),
                      const SizedBox(height: 20), 
                      // ENLACE PARA NAVEGACIÓN AL REGISTRO
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

  // FUNCIÓN PARA MANEJAR EL ENVÍO DEL FORMULARIO
  void onformSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm(); // Valida todos los campos del formulario
    if (isValid) authProvider.login(loginFormProvider.email, loginFormProvider.password); // Si es válido, procede con el login
  }
}