import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/utils/extensions/word_extension.dart';
import 'package:transfer/utils/local_storage.dart';
import 'package:transfer/view/profile/subModules/change_password_screen.dart';
import 'package:transfer/view/profile/subModules/personal_information_screen.dart';
import 'package:transfer/view/profile/widgets/profile_option.dart';

import '../../utils/app_colors.dart';
import '../../utils/constant_strings.dart';
import '../../utils/globarFunctions/launch_web_url.dart';
import '../login/login_screen.dart';
import '../nidVerification/nid_verification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorage _localStorage = LocalStorage();
  bool _loading = true;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  Future<void> getUserInfo() async {
    await context.read<AuthProvider>().getCurrentUserInfo();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: authProvider.userInfo?.own ?? "",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Text(
                          (authProvider.userInfo?.name ?? "").getFirstLetter(),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    authProvider.userInfo?.name ?? "",
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    authProvider.userInfo?.email ?? "",
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
                    title: "NID & Photo Verification",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (authProvider.userInfo?.approve == 1) ...[
                    ProfileOption(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) =>
                                    const PersonalInformationScreen()));
                      },
                      icon: Icons.info_outline,
                      title: "Personal Information",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
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
                          CupertinoPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                    icon: Icons.logout,
                    title: "Log Out",
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      launchWebUrl(url: websiteUrl);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        left: 20,
                        right: 10,
                        top: 8,
                      ),
                      child: Text(
                        "transfer.rajtechteam.com",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
