import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/ui.dart';

class BlankView extends StatelessWidget { // Vista Blank (página vacía de ejemplo)
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Blank', style: CustomLabels.h1),
          const SizedBox(height: 10),
          const WhiteCard(title: 'Blank', child: Text('Blank View'))
        ],
      ),
    );
  }
}