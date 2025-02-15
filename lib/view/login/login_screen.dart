import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/utils/toast.dart';
import 'package:transfer/view/dashboard/dashboard_screen.dart';
import 'package:transfer/view/forgotPassword/forgot_password_screen.dart';
import 'package:transfer/view/login/widgets/input_title.dart';
import 'package:transfer/view/registration/registration_screen.dart';

import '../../common/button_child.dart';
import '../../common/space/add_vertical_space.dart';
import '../../utils/app_colors.dart';
import '../../utils/constant_strings.dart';
import '../../utils/globarFunctions/launch_web_url.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/app_logo.png",
                      width:200,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Login",
                    style: theme.textTheme.displayLarge,
                  ),
                  Text(
                    "Login and enjoy fast transfer",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                      },
                      child: const ButtonChild(
                        text: "Forgot Your Password?",
                        textColor: AppColors.primaryColor,
                      ),
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
                        await _login(authProvider, context);
                      },
                      child: ButtonChild(
                        text: "Log In",
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
                            text: "Want To Register?",
                            style: theme.textTheme.titleLarge,
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.push(context, CupertinoPageRoute(builder: (_) => const RegistrationScreen()));
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
