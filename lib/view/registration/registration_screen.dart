import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/utils/constant_strings.dart';
import 'package:transfer/utils/extensions/email_validator_extension.dart';
import 'package:transfer/utils/toast.dart';
import 'package:transfer/view/dashboard/dashboard_screen.dart';
import 'package:transfer/view/login/login_screen.dart';
import 'package:transfer/view/login/widgets/input_title.dart';

import '../../common/button_child.dart';
import '../../common/space/add_vertical_space.dart';
import '../../utils/app_colors.dart';
import '../webView/webview_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Registration",
                    style: theme.textTheme.displayLarge,
                  ),
                  Text(
                    "Register yourself to transfer money",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const InputTitle(
                    title: "Name",
                  ),
                  const AddVerticalSpace(value: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                        hintText: "Your name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill out this filed";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const AddVerticalSpace(value: 16),
                  const InputTitle(
                    title: "Email",
                  ),
                  const AddVerticalSpace(value: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                        hintText: "Your email address"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill out this filed";
                      }
                      if (!value.isValidEmail()) {
                        return "Invalid email address";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const AddVerticalSpace(value: 16),
                  const InputTitle(
                    title: "Password",
                  ),
                  const AddVerticalSpace(value: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      hintText: "Enter password",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the password";
                      }
                      return null;
                    },
                  ),
                  const AddVerticalSpace(value: 16),
                  const InputTitle(
                    title: "Confirm Password",
                  ),
                  const AddVerticalSpace(value: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _hideConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      hintText: "Enter password",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _hideConfirmPassword = !_hideConfirmPassword;
                          });
                        },
                        child: Icon(
                          _hideConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the password";
                      }

                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                      ),
                      children: [
                        const TextSpan(
                          text: "By signing up, you're agree to our ",
                        ),
                        TextSpan(
                          text: "Terms & Conditions",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => const WebviewScreen(
                                        title: "Terms & Conditions",
                                        url: termsConditionUrl))),
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          var result = await authProvider.registerUser(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text);
                          log(result?.body.toString() ?? "");
                          setState(() {
                            _loading = false;
                          });
                          if (result?.statusCode == 200) {
                            toast(message: "User registered successfully");
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                                (route) => false,
                              );
                            }
                          } else {
                            toast(message: jsonDecode(result!.body)["data"]["email"][0], isError: true);
                          }
                        }
                      },
                      child: ButtonChild(
                        text: "Register",
                        loading: _loading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Back to Login",
                            style: theme.textTheme.titleLarge,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(AuthProvider authProvider, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      var response = await authProvider.getLogin(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        _loading = false;
      });

      if (response?.statusCode == 200) {
        toast(message: "Successfully logged in");
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
        }
      } else {
        toast(message: "Invalid email or password!", isError: true);
      }
    }
  }
}
