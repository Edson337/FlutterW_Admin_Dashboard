import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/ui.dart';

class UserView extends StatefulWidget {
  final String uid;

  const UserView({super.key, required this.uid});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  User? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then((userDB) {
      if (userDB != null) {
        setState(() {user = userDB;});
        userFormProvider.usuario = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
      } else {
        NotificationsService.showSnackBarError('Usuario no encontrado');
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).usuario = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (user == null) WhiteCard(
            child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )
          ),
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
          0: FixedColumnWidth(250)
        },
        children: const [
          TableRow(
            children: [
              _AvatarContainer(),
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
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del usuario',
                label: 'Nombre',
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: (value) => userFormProvider.copyUserWith(nombre: value),
              validator: (value) {
                if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                if (value.length < 2) return 'El nombre debe tener al menos 2 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo del usuario',
                label: 'Correo',
                icon: Icons.mark_email_read_outlined
              ),
              onChanged: (value) => userFormProvider.copyUserWith(correo: value),
              validator: (value) {
                if (!EmailValidator.validate(value ?? '')) return 'Email no válido';
                return null;
              },
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 130),
              child: ElevatedButton(
                onPressed: () async {
                  final saved = await userFormProvider.updateUser();
                  if (saved) {
                    NotificationsService.showSnackBarSuccess('Usuario actualizado correctamente');
                    Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                  } else {
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
            Text('Perfil', style: CustomLabels.h2),
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(child: image),
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
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                            allowMultiple: false,
                          );
                          if (result != null) {
                            NotificationsService.showBusyIndicator(context);
                            PlatformFile file = result.files.first;
                            final newUser = await userFormProvider.uploadImage(file.bytes!, user.uid);
                            userProvider.refreshUser(newUser);
                            Navigator.of(context).pop();
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
            Text(user.nombre, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            Text(user.correo, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          ]
        )
      )
    );
  }
}