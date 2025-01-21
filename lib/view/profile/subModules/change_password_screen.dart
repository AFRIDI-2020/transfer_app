import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/common/button_child.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/utils/local_storage.dart';
import 'package:transfer/utils/toast.dart';
import 'package:transfer/view/login/login_screen.dart';

import '../../../common/space/add_vertical_space.dart';
import '../../login/widgets/input_title.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmedPassword = true;
  final LocalStorage _localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InputTitle(
                title: "Current Password",
              ),
              const AddVerticalSpace(value: 8),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _hideCurrentPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                  ),
                  hintText: "Your current password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _hideCurrentPassword = !_hideCurrentPassword;
                      });
                    },
                    child: Icon(
                      _hideCurrentPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill out this filed";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const AddVerticalSpace(value: 15),
              const InputTitle(
                title: "New Password",
              ),
              const AddVerticalSpace(value: 8),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _hideNewPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                  ),
                  hintText: "Enter new password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _hideNewPassword = !_hideNewPassword;
                      });
                    },
                    child: Icon(
                      _hideNewPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill out this filed";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const AddVerticalSpace(value: 15),
              const InputTitle(
                title: "Confirm New Password",
              ),
              const AddVerticalSpace(value: 8),
              TextFormField(
                controller: _confirmedPasswordController,
                obscureText: _hideConfirmedPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                  ),
                  hintText: "Confirm new password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _hideConfirmedPassword = !_hideConfirmedPassword;
                      });
                    },
                    child: Icon(
                      _hideConfirmedPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill out this filed";
                  }

                  if (value != _newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const AddVerticalSpace(value: 15),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      var response = await authProvider.changePassword(
                        currentPassword: _currentPasswordController.text,
                        newPassword: _newPasswordController.text,
                      );
                      setState(() {
                        _loading = false;
                      });

                      if (response?.statusCode == 200) {
                        _localStorage.removeSession();
                        toast(message: "Password changed successfully");

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      } else {
                        toast(
                            message: "Changing password failed!",
                            isError: true);
                      }
                    }
                  },
                  child: ButtonChild(
                    text: "Change Password",
                    loading: _loading,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
