import 'package:flutter/material.dart';
import 'package:gestioncontenu/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final auth = context.read<AuthProvider>();
      await auth.loadSession();
      if (!mounted) return;
      if (auth.isAuthenticated) {
        if (auth.user?.role == 'editor') {
          Navigator.of(context).pushReplacementNamed('/home_editor');
        } else {
          Navigator.of(context).pushReplacementNamed('/home_viewer');
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}
