import 'package:flutter/material.dart';
import 'package:gestioncontenu/pages/app_start.dart';
import 'package:gestioncontenu/pages/content_detail_page.dart';
import 'package:gestioncontenu/pages/home_editor_page.dart';
import 'package:gestioncontenu/pages/home_viewer_page.dart';
import 'package:gestioncontenu/pages/login_page.dart';
import 'package:gestioncontenu/pages/signup_page.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:gestioncontenu/providers/content_provider.dart';
import 'package:gestioncontenu/services/api_client.dart';
import 'package:gestioncontenu/services/auth_service.dart';
import 'package:gestioncontenu/services/content_service.dart';
import 'package:gestioncontenu/services/token_storage.dart';
import 'package:gestioncontenu/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final storage = TokenStorage();
    final api = ApiClient(storage);
    final authService = AuthService(api);
    final contentService = ContentService(api);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService, storage)),
        ChangeNotifierProvider(create: (ctx) => ContentProvider(contentService, ctx.read<AuthProvider>())),
      ],
      child: MaterialApp(
        title: 'Mini CMS',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const AppStart(),
          LoginPage.routeName: (context) => const LoginPage(),
          SignupPage.routeName: (context) => const SignupPage(),
          HomeViewerPage.routeName: (context) => const HomeViewerPage(),
          HomeEditorPage.routeName: (context) => const HomeEditorPage(),
          ContentDetailPage.routeName: (context) => const ContentDetailPage(),
        },
      ),
    );
  }
}
