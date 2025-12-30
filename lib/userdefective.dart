import 'dart:ui';
import 'package:flutter/material.dart';
import 'user_profile_page.dart';
import 'common_success_page.dart';
import 'home_page.dart';

class DefectiveCylinderPage extends StatefulWidget {
  const DefectiveCylinderPage({super.key});

  @override
  State<DefectiveCylinderPage> createState() => _DefectiveCylinderPageState();
}

class _DefectiveCylinderPageState extends State<DefectiveCylinderPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final consumerController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final defectController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    consumerController.dispose();
    phoneController.dispose();
    addressController.dispose();
    defectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Defective Cylinder Complaint",
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
                        controller: defectController,
                        label: "Defect Description",
                        icon: Icons.warning,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 30),

                      // SUBMIT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CommonSuccessPage(
                                    title: "Complaint Submitted!",
                                    message:
                                        "Your defective cylinder complaint has been submitted successfully.\nOur team will contact you shortly.",
                                    onDone: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const HomePage(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
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

      // BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFD5000),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
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

  // FORM FIELD
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
        validator: (v) =>
            v == null || v.trim().isEmpty ? "Enter $label" : null,
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
