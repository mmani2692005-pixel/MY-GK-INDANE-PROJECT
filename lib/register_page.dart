import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> register() async {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    var url = Uri.parse("http://localhost/flutter_api/register.php");

    var response = await http.post(
      url,
      body: {
        "username": usernameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
      },
    );

    var data = json.decode(response.body);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: usernameController,
                  decoration: input("Username")),
              const SizedBox(height: 10),
              TextField(
                  controller: emailController, decoration: input("Email")),
              const SizedBox(height: 10),
              TextField(
                  controller: phoneController, decoration: input("Phone")),
              const SizedBox(height: 10),
              TextField(
                  controller: passwordController,
                  decoration: input("Password"),
                  obscureText: true),
              const SizedBox(height: 10),
              TextField(
                  controller: confirmController,
                  decoration: input("Confirm Password"),
                  obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Text("REGISTER"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
