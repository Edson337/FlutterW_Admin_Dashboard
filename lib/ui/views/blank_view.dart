import 'package:flutter/material.dart';

import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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