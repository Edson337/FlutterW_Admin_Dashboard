import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Manejo de estado con Provider

import 'package:admin_dashboard/providers/providers.dart'; // Proveedores de estado de la aplicación
import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el usuario autenticado desde el AuthProvider
    // El '!' indica que asumimos que el usuario ya está autenticado en esta vista
    final user = Provider.of<AuthProvider>(context).user!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Espaciado interno del contenedor
      child: ListView(
        physics: const ClampingScrollPhysics(), // Evita el efecto de rebote en el scroll
        children: [
          // TÍTULO PRINCIPAL DEL DASHBOARD
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // TARJETA DE INFORMACIÓN DEL USUARIO
          // Muestra el nombre del usuario como título y el correo como contenido
          WhiteCard(title: user.nombre, child: Text(user.correo))
        ],
      ),
    );
  }
}