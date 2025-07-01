import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget { // Widget que representa un ícono de notificaciones con un pequeño indicador rojo
  const NotificationsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Contenedor base
      child: Stack( // Usamos un Stack para superponer el ícono de notificación y el indicador
        children: [
          const Icon(Icons.notifications_none_outlined, color: Colors.grey),
          Positioned( // Posiciona el indicador rojo respecto al ícono
            left: 3, // Lo mueve un poco a la izquierda
            child: Container(
              width: 5,
              height: 5,
              decoration: buildBoxDecoration(), // Le da forma y color
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration( // Método para construir la decoración del punto rojo
    color: Colors.red, // Color rojo (indicador de notificación pendiente)
    borderRadius: BorderRadius.circular(100) // Bordes completamente redondeados para hacerlo circular
  );
}