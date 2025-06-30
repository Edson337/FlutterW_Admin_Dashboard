import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/datatables/datasources.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/ui.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final usersDataSourse = UsersDTS(usersProvider.users);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Users', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            columns: [
              const DataColumn(label: Text('Avatar')),
              DataColumn(label: const Text('Nombre'), onSort: (colIndex, _) {
                usersProvider.sortColumnIndex = colIndex;
                usersProvider.sort<String>((user) => user.nombre);
              }),
              DataColumn(label: const Text('Email'), onSort: (colIndex, _) {
                usersProvider.sortColumnIndex = colIndex;
                usersProvider.sort<String>((user) => user.correo);
              }),
              const DataColumn(label: Text('UID')),
              const DataColumn(label: Text('Acciones')),
            ],
            source: usersDataSourse,
            onPageChanged: (page) {},
          )
        ],
      ),
    );
  }
}