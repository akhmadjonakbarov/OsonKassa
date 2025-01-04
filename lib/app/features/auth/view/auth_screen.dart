import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/container_decoration.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/helper/valid_alert.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../../utils/texts/button_texts.dart';
import '../../../utils/texts/display_texts.dart';
import '../../../utils/texts/user_texts.dart';
import '../../shared/widgets/app_container.dart';
import '../../shared/widgets/buttons.dart';
import '../logic/controllers/auth_ctl.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final AuthCtl _authController = Get.find<AuthCtl>();

  bool isRegister = false;

  @override
  void didChangeDependencies() {
    _authController.auth();
    super.didChangeDependencies();
  }

  _submit() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      if (isRegister) {
        _authController.register(
          email: _loginController.text.trim(),
          password: _passwordController.text.trim(),
          password2: _password2Controller.text.trim(),
          first_name: _firstNameController.text.trim(),
          last_name: _lastNameController.text.trim(),
        );
      } else {
        _authController.login(
          email: _loginController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    }
  }

  // Method to show the "Forgot Password" dialog remains unchanged
  // Method to show the "Forgot Password" dialog
  Future<void> _showForgotPasswordDialog() async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Parolni o\'zgartirish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Yangi parol',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              )
            ],
          ),
          actions: <Widget>[
            DialogTextButton(
              text: ButtonTexts.cancel,
              textStyle: textStyleWhite18,
              onClick: () {},
              isNegative: true,
            ),
            DialogTextButton(
              onClick: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  // Trigger your controller method for password reset
                  _authController.resetPassword(
                    email: email,
                    new_password: password,
                  );
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show a message or handle empty email case
                  Get.snackbar('Error', 'Please enter a valid email');
                }
              },
              text: ButtonTexts.edit,
              textStyle: textStyleWhite18,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return Scaffold(
      body: Center(
        child: AppContainer(
          width: screenSize.width * 0.6,
          height: screenSize.height *
              0.8, // Increased height to accommodate new fields
          decoration: containerDecoration,
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isRegister
                      ? DisplayTexts.register
                      : DisplayTexts.welcome_dashboard,
                  style: textStyleBlack18.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16.0),

                // First Name field for registration
                if (isRegister)
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: textStyleBlack18.copyWith(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    style: textStyleBlack18,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16.0),

                // Last Name field for registration
                if (isRegister)
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: textStyleBlack18.copyWith(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                    style: textStyleBlack18,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16.0),

                // Email field
                TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: UserTexts.email,
                    labelStyle: textStyleBlack18.copyWith(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  style: textStyleBlack18,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validField(UserTexts.email);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: UserTexts.password,
                    labelStyle: textStyleBlack18.copyWith(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  style: textStyleBlack18,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validField(UserTexts.password);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Confirm Password field for registration
                if (isRegister)
                  TextFormField(
                    controller: _password2Controller,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: textStyleBlack18.copyWith(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    style: textStyleBlack18,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16.0),

                // "Forgot Password" link for login
                if (!isRegister)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: const Text("Parolni unutdingizmi?"),
                    ),
                  ),
                const SizedBox(height: 16.0),

                SmallButtonText(
                  text: isRegister ? ButtonTexts.register : ButtonTexts.enter,
                  onClick: _submit,
                  buttonSize: Size(screenSize.width * 0.2, 50),
                  textStyle: textStyleBlack18,
                ),
                const SizedBox(height: 10),

                // Toggle between Register/Login
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRegister = !isRegister;
                    });
                  },
                  child: Text(isRegister
                      ? "Ҳисобингиз борми? Кириш"
                      : "Ҳисобингиз йўқми? Рўйҳатдан ўтиш"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
