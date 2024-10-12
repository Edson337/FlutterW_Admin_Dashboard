import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../router/router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sidemenu_provider.dart';
import '../../services/navigation_service.dart';
import 'widgets/logo.dart';
import 'widgets/menu_item.dart';
import 'widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Main'),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute)
          ),
          MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined, onPressed: () {}),
          MenuItem(text: 'Analytics', icon: Icons.show_chart_outlined, onPressed: () {}),
          MenuItem(text: 'Categories', icon: Icons.layers_outlined, onPressed: () {}),
          MenuItem(text: 'Products', icon: Icons.dashboard_outlined, onPressed: () {}),
          MenuItem(text: 'Discount', icon: Icons.attach_money_outlined, onPressed: () {}),
          MenuItem(text: 'Customers', icon: Icons.people_alt_outlined, onPressed: () {}),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            text: 'Icons',
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.iconsRoute)
          ),
          MenuItem(text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: () {}),
          MenuItem(text: 'Campaign', icon: Icons.note_add_outlined, onPressed: () {}),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
            text: 'Blank Page',
            icon: Icons.post_add_outlined,
            onPressed: () => navigateTo(Flurorouter.blankRoute)
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout()
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]
  );
}