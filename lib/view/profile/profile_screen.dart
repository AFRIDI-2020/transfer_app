import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transfer/utils/local_storage.dart';
import 'package:transfer/view/profile/subModules/change_password_screen.dart';
import 'package:transfer/view/profile/widgets/profile_option.dart';

import '../../utils/app_colors.dart';
import '../login/login_screen.dart';
import '../nidVerification/nid_verification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                  shape: BoxShape.circle),
              height: 130,
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/ic_profile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Olivia Morris",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 6,
            ),

            Text(
              "olivia.morris@gmail.com",
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileOption(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => const NidVerificationScreen()));
              },
              icon: Icons.remember_me,
              title: "NID Verification",
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileOption(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => const ChangePasswordScreen()));
              },
              icon: Icons.vpn_key,
              title: "Change Password",
            ),
            const SizedBox(
              height: 15,
            ),
            ProfileOption(
              onTap: () {
                _localStorage.removeSession();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
              icon: Icons.logout,
              title: "Log Out",
            ),
          ],
        ),
      ),
    );
  }
}
