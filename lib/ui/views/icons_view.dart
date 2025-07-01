import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Espaciado interno del contenedor
      child: ListView(
        physics: const ClampingScrollPhysics(), // Evita el efecto de rebote en el scroll
        children: [
          // TÍTULO PRINCIPAL DE LA VISTA DE ICONOS
          Text('Icons', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // CONTENEDOR WRAP PARA DISPOSICIÓN FLEXIBLE DE ICONOS
          // Wrap permite que los elementos se ajusten automáticamente al ancho disponible
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start, // Alineación vertical al inicio
            direction: Axis.horizontal, // Dirección horizontal para la disposición
            children: [
              // GALERÍA DE ICONOS EN TARJETAS INDIVIDUALES
              // Cada WhiteCard muestra un icono específico con su nombre como título
              WhiteCard(title: 'ac_unit_outlined', width: 170, child: Center(child: Icon(Icons.ac_unit_outlined))),
              WhiteCard(title: 'access_alarm_outlined', width: 170, child: Center(child: Icon(Icons.access_alarm_outlined))),
              WhiteCard(title: 'access_time_outlined', width: 170, child: Center(child: Icon(Icons.access_time_outlined))),
              WhiteCard(title: 'all_inbox_outlined', width: 170, child: Center(child: Icon(Icons.all_inbox_outlined))),
              WhiteCard(title: 'desktop_mac_rounded', width: 170, child: Center(child: Icon(Icons.desktop_mac_rounded))),
              WhiteCard(title: 'keyboard_tab_outlined', width: 170, child: Center(child: Icon(Icons.keyboard_tab_outlined))),
              WhiteCard(title: 'not_listed_location', width: 170, child: Center(child: Icon(Icons.not_listed_location))),
            ],
          )
        ],
      ),
    );
  }
}