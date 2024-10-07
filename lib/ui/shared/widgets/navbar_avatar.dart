import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 30,
        height: 30,
        child: Image.asset('Usuario.png'),
      ),
    );
  }
}