import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/ui.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.dashboardRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler icons = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.iconsRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.blankRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  static Handler categories = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.categoriesRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CategoriesView();
    } else {
      return const LoginView();
    }
  });

  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.usersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.userRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        final String uid = params['uid']!.first;
        return UserView(uid: uid);
      } else {
        return const UsersView();
      }
    } else {
      return const LoginView();
    }
  });
}