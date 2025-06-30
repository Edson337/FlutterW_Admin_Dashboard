import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/ui.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
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
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider())
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
      scaffoldMessengerKey: NotificationsService.messengerKey,
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
        scrollbarTheme: const ScrollbarThemeData().copyWith(thumbColor: WidgetStateProperty.all(Colors.white30))
      ),
    );
  }
}