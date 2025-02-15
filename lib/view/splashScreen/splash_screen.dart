import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transfer/utils/app_colors.dart';
import 'package:transfer/utils/constant_strings.dart';
import 'package:transfer/utils/globarFunctions/launch_web_url.dart';
import 'package:transfer/utils/local_storage.dart';
import 'package:transfer/view/dashboard/dashboard_screen.dart';
import 'package:transfer/view/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage _storage = LocalStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        String token = _storage.token;
        log(token);

        if (token.isNotEmpty) {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          }
        }
        if (token.isEmpty) {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launchWebUrl(url: websiteUrl);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 20, right: 10, top: 8,),
          child: Text(
            "transfer.rajtechteam.com",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
      body: Center(
        child: Image.asset(
          "assets/app_logo.png",
          width: 300,
        ),
      ),
    );
  }



}
