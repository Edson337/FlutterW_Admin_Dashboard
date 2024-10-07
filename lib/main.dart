import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/router.dart';
import 'providers/auth_provider.dart';
import 'providers/sidemenu_provider.dart';
import 'services/local_storage.dart';
import 'services/navigation_service.dart';
import 'ui/layouts/auth/auth_layout.dart';
import 'ui/layouts/dashboard/dashboard_layout.dart';
import 'ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()), 
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking) return const SplashLayout();
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData()
              .copyWith(thumbColor: WidgetStateProperty.all(Colors.white30))),
    );
  }
}