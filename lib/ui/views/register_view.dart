import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart'; // Validador de emails

import 'package:admin_dashboard/providers/providers.dart'; // Proveedores de estado
import 'package:admin_dashboard/router/router.dart'; // Rutas de navegación
import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración de múltiples providers anidados para el formulario de registro
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(), // Provider para manejar el estado del formulario de registro
      child: Builder(builder: (context) {
        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
        return ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(), // Provider para alternar visibilidad de contraseña
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370), // Limita el ancho máximo del formulario
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus, // Valida automáticamente cuando el campo pierde el foco
                  key: registerFormProvider.formKey, // Clave del formulario para validaciones
                  child: Column(
                    children: [
                      // CAMPO DE NOMBRE CON VALIDACIÓN
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su nombre',
                          label: 'Nombre',
                          icon: Icons.person
                        ),
                        onChanged: (value) => registerFormProvider.name = value, // Actualiza el nombre en el provider
                        validator: (value) {
                          // Validación de campo obligatorio para el nombre
                          if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // CAMPO DE EMAIL CON VALIDACIÓN AVANZADA
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Coloque su correo',
                          label: 'Correo Electrónico',
                          icon: Icons.email_outlined
                        ),
                        onChanged: (value) => registerFormProvider.email = value, // Actualiza el email en el provider
                        validator: (value) {
                          // Validaciones del email: obligatorio y formato válido
                          if (value == null || value.isEmpty) return 'El correo electrónico es obligatorio';
                          if (!EmailValidator.validate(value)) return 'Correo electrónico no válido';
                          return null;
                        },
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
                            onChanged: (value) => registerFormProvider.password = value, // Actualiza la contraseña en el provider
                            validator: (value) {
                              // Validaciones de contraseña: obligatoria y longitud mínima
                              if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
                              if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // BOTÓN PRINCIPAL PARA CREAR CUENTA
                      CustomOutlinedBtn(
                        onPressed: () {
                          // Validación del formulario antes del registro
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return; // Si no es válido, detiene la ejecución
                          
                          // Obtiene el AuthProvider y procede con el registro
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          authProvider.register(registerFormProvider.name, registerFormProvider.email, registerFormProvider.password);
                        },
                        text: 'Crear cuenta',
                      ),
                      const SizedBox(height: 20),
                      // ENLACE PARA NAVEGACIÓN AL LOGIN
                      LinkText(
                        text: 'Inicio de Sesión',
                        onPressed: () => Navigator.pushReplacementNamed(context, Flurorouter.loginRoute)
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