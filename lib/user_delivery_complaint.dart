import 'dart:ui';
import 'package:flutter/material.dart';
import 'adminhome_page.dart';
import 'user_profile_page.dart';

class DeliveryComplaintPage extends StatefulWidget {
  const DeliveryComplaintPage({super.key});

  @override
  State<DeliveryComplaintPage> createState() => _DeliveryComplaintPageState();
}

class _DeliveryComplaintPageState extends State<DeliveryComplaintPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final consumerController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final complaintController = TextEditingController();

  int _selectedIndex = 0;

  // ─────────────────────────────────────────────
  // ADMIN LOGIN DIALOG (MODERN)
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
          "Delivery Complaint",
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
                        label: "Name",
                        icon: Icons.person,
                      ),
                      _field(
                        controller: consumerController,
                        label: "Consumer Number",
                        icon: Icons.format_list_numbered,
                      ),
                      _field(
                        controller: phoneController,
                        label: "Phone Number",
                        icon: Icons.phone,
                        keyboard: TextInputType.phone,
                      ),
                      _field(
                        controller: addressController,
                        label: "Address",
                        icon: Icons.location_on,
                        maxLines: 3,
                      ),
                      _field(
                        controller: complaintController,
                        label: "Delivery Issue",
                        icon: Icons.delivery_dining,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 30),

                      // ---------------- SUBMIT BUTTON ----------------
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Delivery Complaint Submitted Successfully"),
                                  backgroundColor: Color(0xFFFD5000),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFD5000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                          ),
                          child: const Text(
                            "SUBMIT COMPLAINT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

      // ─────────────────────────────────────────────
      // BOTTOM NAV (MODERN)
      // ─────────────────────────────────────────────
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 1) {
            showAdminLoginDialog();
            return;
          }

          setState(() => _selectedIndex = index);

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserProfilePage(),
              ),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.admin_panel_settings), label: "Admin"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // FORM FIELD
  // ─────────────────────────────────────────────
  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboard,
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
