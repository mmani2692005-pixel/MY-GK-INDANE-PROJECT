import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/adminhome_page.dart';
import 'package:app/user_profile_page.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

class NewConnectionPage extends StatefulWidget {
  const NewConnectionPage({super.key});

  @override
  State<NewConnectionPage> createState() => _NewConnectionPageState();
}

class _NewConnectionPageState extends State<NewConnectionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? aadharFile;
  final ImagePicker _picker = ImagePicker();

  // ─────────────────────────────────────────────
  // ADMIN LOGIN POPUP (UNCHANGED)
  // ─────────────────────────────────────────────
  void showAdminLoginDialog() {
    TextEditingController passController = TextEditingController();
    bool showPassword = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Admin Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFD5000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => showPassword = !showPassword);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Back"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFD5000),
                          ),
                          onPressed: () {
                            if (passController.text == "1234") {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AdminHomePage(),
                                ),
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
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ─────────────────────────────────────────────
  // PICK AADHAR
  // ─────────────────────────────────────────────
  Future<void> pickAadhar() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => aadharFile = File(pickedFile.path));
    }
  }

  // ─────────────────────────────────────────────
  // SUBMIT FORM
  // ─────────────────────────────────────────────
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (aadharFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload Aadhaar")),
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
  // BUILD UI
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "New Connection Apply",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // FORM CONTENT
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(
                controller: nameController,
                label: "Full Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildField(
                controller: ageController,
                label: "Age",
                icon: Icons.elderly,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter age";
                  final age = int.tryParse(value);
                  if (age == null || age < 18) {
                    return "Age must be 18 or above";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildField(
                controller: phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter phone number";
                  } else if (value.length != 10) {
                    return "Enter valid 10 digit number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildField(
                controller: addressController,
                label: "Address",
                icon: Icons.location_on,
                maxLines: 3,
              ),
              const SizedBox(height: 15),
              _buildField(
                controller: aadharController,
                label: "Aadhar Number",
                icon: Icons.badge,
                maxLength: 10,
              ),
              const SizedBox(height: 20),

              // AADHAR UPLOAD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Upload Aadhaar Card",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    aadharFile != null
                        ? Image.file(aadharFile!, height: 150)
                        : const Text("No file selected"),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: pickAadhar,
                      icon: const Icon(Icons.upload),
                      label: const Text("Choose File"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFD5000),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFD5000),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "SUBMIT APPLICATION",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // ⭐ BOTTOM NAVIGATION BAR (UPDATED PROFILE)
      // ─────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFD5000),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Home
          } else if (index == 1) {
            showAdminLoginDialog(); // Admin
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserProfilePage(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Admin"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // REUSABLE FIELD
  // ─────────────────────────────────────────────
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator ??
          (value) => value == null || value.isEmpty ? "Enter $label" : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        counterText: "",
      ),
    );
  }
}
