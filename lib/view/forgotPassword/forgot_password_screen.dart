import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/utils/extensions/email_validator_extension.dart';
import 'package:transfer/utils/toast.dart';
import 'package:transfer/view/login/login_screen.dart';

import '../../provider/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.vpn_key,
                  size: 150,
                ),
                Text(
                  "Forgot Password?",
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "No worries, we will send you password\nreset instruction",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  cursorColor: theme.colorScheme.onSurface,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email address";
                    }
                    if (!value.isValidEmail()) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        var response = await authProvider.sendForgotPasswordRequest(email: _emailController.text);
                        setState(() {
                          _loading = false;
                        });
                        log(response?.statusCode.toString() ?? "");
                        if(response?.statusCode == 200) {
                          toast(message: "You have been sent a Resent Password email");
                          if(context.mounted) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false,);
                          }
                        }
                      }
                    },
                    child: _loading
                        ? CircularProgressIndicator(
                            color: theme.colorScheme.onPrimary,
                          )
                        : const Text("Reset Password"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: theme.colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Back to Login",
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
