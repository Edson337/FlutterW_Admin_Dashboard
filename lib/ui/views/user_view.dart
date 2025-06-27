import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http/user.dart';
import '../../providers/user_form_provider.dart';
import '../../providers/users_provider.dart';
import '../../services/navigation_service.dart';
import '../../services/notifications_service.dart';
import '../cards/white_card.dart';
import '../inputs/custom_inputs.dart';
import '../labels/custom_labels.dart';

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
  const _UserViewBody({
    super.key,
  });

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
  const _UserViewForm({
    super.key,
  });

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
  const _AvatarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.usuario!;

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
                  const ClipOval(
                    child: Image(
                      image: AssetImage('no-image.jpg')
                    ),
                  ),
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
                        onPressed: () {},
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