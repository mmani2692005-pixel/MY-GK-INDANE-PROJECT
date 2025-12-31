import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'newreg_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF6A00),
              Color(0xFFFFB347),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 420),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// LOGO
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "assets/logo.png",
                            height: 70,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Welcome Back 👋",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Login to continue",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// PHONE FIELD
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          //maxLength: 10,
                          decoration: _inputDecoration(
                            label: "Phone Number",
                            icon: Icons.phone_rounded,
                          ),
                          //validator: (value) {
                           // if (value == null || value.isEmpty) {
                             // return "Enter phone number";
                           // }
                          //  if (value.length != 10) {
                             // return "Enter valid 10-digit number";
                           // }
                          //  return null;
                          //},
                        ),

                        const SizedBox(height: 18),

                        /// PASSWORD FIELD
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: _inputDecoration(
                            label: "Password",
                            icon: Icons.lock_rounded,
                            suffix: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          //validator: (value) {
                          //  if (value == null || value.isEmpty) {
                           //   return "Enter password";
                         //   }
                          //  if (value.length < 8) {
                         ///     return "Minimum 8 characters required";
                           // }
                           // return null;
                         // },
                        ),

                        const SizedBox(height: 30),

                        /// LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => isLoading = true);
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      setState(() => isLoading = false);

                                      Navigator.pushReplacement(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const HomePage(),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: const Color(0xFFff512f),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New here? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFdd2476),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT DECORATION
  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      counterText: "",
    );
  }
}
