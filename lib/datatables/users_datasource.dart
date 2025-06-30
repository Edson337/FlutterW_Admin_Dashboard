import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/services/services.dart';

class UsersDTS extends DataTableSource {
  final List<User> users;

  UsersDTS(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index];
    final image = (user.img == null) 
    ? const Image(image: AssetImage('no-image.jpg'), width: 35, height: 35) 
    : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, width: 35, height: 35);
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(ClipOval(child: image)),
        DataCell(Text(user.nombre)),
        DataCell(Text(user.correo)),
        DataCell(Text(user.uid)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => NavigationService.replaceTo('/dashboard/users/${user.uid}'),
          ),
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}