import 'package:flutter/material.dart';
import 'package:transfer/utils/local_storage.dart';
import 'package:transfer/view/dashboard/dashboard_screen.dart';
import 'package:transfer/view/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage _storage = LocalStorage();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (_storage.token.isNotEmpty) {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Transfer"),
      ),
    );
  }
}
