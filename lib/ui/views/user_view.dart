import 'package:email_validator/email_validator.dart'; // Validador de emails
import 'package:file_picker/file_picker.dart'; // Selector de archivos para subir imágenes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/models/models.dart'; // Modelos de datos
import 'package:admin_dashboard/providers/providers.dart'; // Proveedores de estado
import 'package:admin_dashboard/services/services.dart'; // Servicios de la aplicación
import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class UserView extends StatefulWidget {
  final String uid; // ID único del usuario a mostrar/editar

  const UserView({super.key, required this.uid});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  User? user; // Usuario actual, null mientras se carga

  @override
  void initState() {
    super.initState();
    // Obtención de providers necesarios para manejar usuarios y formularios
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>(context, listen: false);

    // CARGA ASÍNCRONA DEL USUARIO POR ID
    usersProvider.getUserById(widget.uid).then((userDB) {
      if (userDB != null) {
        // Si el usuario existe, actualiza el estado y configura el formulario
        setState(() {user = userDB;});
        userFormProvider.usuario = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
      } else {
        // Si no existe, muestra error y redirige a la lista de usuarios
        NotificationsService.showSnackBarError('Usuario no encontrado');
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    // LIMPIEZA DE RECURSOS AL SALIR DE LA VISTA
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).usuario = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(), // Evita el efecto de rebote en el scroll
        children: [
          // TÍTULO DE LA VISTA
          Text('User', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // INDICADOR DE CARGA MIENTRAS SE OBTIENE EL USUARIO
          if (user == null) WhiteCard(
            child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )
          ),
          // CONTENIDO PRINCIPAL CUANDO EL USUARIO ESTÁ CARGADO
          if (user != null) const _UserViewBody()
        ]
      )
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(250) // Ancho fijo para la columna del avatar
        },
        children: const [
          TableRow(
            children: [
              // CONTENEDOR DEL AVATAR Y PERFIL DEL USUARIO
              _AvatarContainer(),
              // FORMULARIO DE EDICIÓN DE DATOS DEL USUARIO
              _UserViewForm(),
            ]
          )
        ]
      )
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm();

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.usuario!;

    return WhiteCard(
      title: 'Información general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always, // Validación en tiempo real
        child: Column(
          children: [
            // CAMPO DE NOMBRE CON VALIDACIÓN
            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del usuario',
                label: 'Nombre',
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: (value) => userFormProvider.copyUserWith(nombre: value), // Actualiza el nombre en el provider
              validator: (value) {
                // Validaciones del nombre: obligatorio y longitud mínima
                if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                if (value.length < 2) return 'El nombre debe tener al menos 2 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 20),
            // CAMPO DE CORREO CON VALIDACIÓN DE EMAIL
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo del usuario',
                label: 'Correo',
                icon: Icons.mark_email_read_outlined
              ),
              onChanged: (value) => userFormProvider.copyUserWith(correo: value), // Actualiza el correo en el provider
              validator: (value) {
                // Validación del formato de email
                if (!EmailValidator.validate(value ?? '')) return 'Email no válido';
                return null;
              },
            ),
            const SizedBox(height: 20),
            // BOTÓN PARA GUARDAR CAMBIOS DEL USUARIO
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 130),
              child: ElevatedButton(
                onPressed: () async {
                  // Proceso de actualización del usuario
                  final saved = await userFormProvider.updateUser();
                  if (saved) {
                    // Si se guardó correctamente, muestra mensaje de éxito y actualiza la lista
                    NotificationsService.showSnackBarSuccess('Usuario actualizado correctamente');
                    Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                  } else {
                    // Si falló, muestra mensaje de error
                    NotificationsService.showSnackBarError('Error al actualizar el usuario');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.indigo),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.save_outlined, color: Colors.white, size: 20),
                    Text(' Guardar', style: TextStyle(color: Colors.white))
                  ],
                )
              ),
            )
          ],
        )
      )
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer();

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final user = userFormProvider.usuario!;
    
    // CONFIGURACIÓN DE LA IMAGEN: placeholder si no hay imagen, o imagen de red
    final image = (user.img == null) 
    ? const Image(image: AssetImage('no-image.jpg')) 
    : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);

    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TÍTULO DE LA SECCIÓN DE PERFIL
            Text('Perfil', style: CustomLabels.h2),
            const SizedBox(height: 20),
            // CONTENEDOR DEL AVATAR CON BOTÓN DE CÁMARA
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  // IMAGEN CIRCULAR DEL USUARIO
                  ClipOval(child: image),
                  // BOTÓN FLOTANTE PARA CAMBIAR IMAGEN
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5)
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        child: const Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white,),
                        onPressed: () async {
                          // PROCESO DE SELECCIÓN Y SUBIDA DE IMAGEN
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png'], // Solo imágenes permitidas
                            allowMultiple: false,
                          );
                          if (result != null) {
                            // Si se seleccionó una imagen, muestra indicador de carga
                            NotificationsService.showBusyIndicator(context);
                            PlatformFile file = result.files.first;
                            // Sube la imagen y actualiza el usuario
                            final newUser = await userFormProvider.uploadImage(file.bytes!, user.uid);
                            userProvider.refreshUser(newUser);
                            Navigator.of(context).pop(); // Cierra el indicador de carga
                          } else {
                            print('No hay imagen seleccionada');
                          }
                        }
                      )
                    )
                  )
                ]
              )
            ),
            const SizedBox(height: 20),
            // INFORMACIÓN BÁSICA DEL USUARIO
            Text(user.nombre, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Text(user.correo, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          ]
        )
      )
    );
  }
}