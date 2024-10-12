import 'package:flutter/material.dart';

import '../cards/white_card.dart';
import '../labels/custom_labels.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Icons', style: CustomLabels.h1),
          const SizedBox(height: 10),
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
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