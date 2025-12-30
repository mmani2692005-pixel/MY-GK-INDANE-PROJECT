import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'adminhome_page.dart';
import 'user_profile_page.dart';

class NewConnectionPage extends StatefulWidget {
  const NewConnectionPage({super.key});

  @override
  State<NewConnectionPage> createState() => _NewConnectionPageState();
}

class _NewConnectionPageState extends State<NewConnectionPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final aadharController = TextEditingController();
  final phoneController = TextEditingController();

  File? aadharFile;
  final ImagePicker _picker = ImagePicker();

  int _selectedIndex = 0;

  // ─────────────────────────────────────────────
  // ADMIN LOGIN (MODERN)
  // ─────────────────────────────────────────────
  void showAdminLoginDialog() {
    final passController = TextEditingController();
    bool showPassword = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              "Admin Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextField(
              controller: passController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: "Enter admin password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD5000),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  if (passController.text == "1234") {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid Password"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // PICK AADHAR
  // ─────────────────────────────────────────────
  Future<void> pickAadhar() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => aadharFile = File(picked.path));
    }
  }

  // ─────────────────────────────────────────────
  // SUBMIT
  // ─────────────────────────────────────────────
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (aadharFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload Aadhaar card")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New Connection Application Submitted"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    aadharController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // UI
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "New Connection Apply",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFD5000), Color(0xFFFFE0CC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 110, 16, 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _field(
                        controller: nameController,
                        label: "Full Name",
                        icon: Icons.person,
                      ),
                      _field(
                        controller: ageController,
                        label: "Age",
                        icon: Icons.elderly,
                        keyboard: TextInputType.number,
                        validator: (v) {
                          final age = int.tryParse(v ?? "");
                          if (age == null || age < 18) {
                            return "Age must be 18 or above";
                          }
                          return null;
                        },
                      ),
                      _field(
                        controller: phoneController,
                        label: "Phone Number",
                        icon: Icons.phone,
                        keyboard: TextInputType.phone,
                        maxLength: 10,
                        validator: (v) => v != null && v.length == 10
                            ? null
                            : "Invalid phone",
                      ),
                      _field(
                        controller: addressController,
                        label: "Address",
                        icon: Icons.location_on,
                        maxLines: 3,
                      ),
                      _field(
                        controller: aadharController,
                        label: "Aadhaar Number",
                        icon: Icons.badge,
                        maxLength: 12,
                      ),
                      const SizedBox(height: 20),

                      // ---------------- AADHAR UPLOAD ----------------
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Upload Aadhaar Card",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            aadharFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      aadharFile!,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Text("No file selected"),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: pickAadhar,
                              icon: const Icon(Icons.upload),
                              label: const Text("Choose File"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFD5000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ---------------- SUBMIT ----------------
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFD5000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                          ),
                          child: const Text(
                            "SUBMIT APPLICATION",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0, // Home selected
  selectedItemColor: const Color(0xFFFD5000),
  unselectedItemColor: Colors.grey,
  onTap: (index) {
    if (index == 0) {
      // Home
      Navigator.pop(context);
    } else if (index == 1) {
      // Profile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const UserProfilePage(),
        ),
      );
    }
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ],
),
    );
  }

  // ---------------- FIELD ----------------
  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboard,
        validator:
            validator ?? (v) => v == null || v.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          counterText: "",
        ),
      ),
    );
  }
}
