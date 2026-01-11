import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // 👈 for kIsWeb

import 'user_profile_page.dart';
import 'common_success_page.dart';
import 'home_page.dart';

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
  Uint8List? webImageBytes;
  final ImagePicker _picker = ImagePicker();

  // ================= PICK IMAGE =================
  Future<void> pickAadhar() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        webImageBytes = await picked.readAsBytes();
      } else {
        aadharFile = File(picked.path);
      }
      setState(() {});
    }
  }

  // ================= SUBMIT FORM =================
  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (!kIsWeb && aadharFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload Aadhaar card")),
      );
      return;
    }

    try {
      String apiUrl;

      if (kIsWeb) {
        apiUrl = "http://localhost/flutter_api/new_connection.php";
      } else {
        apiUrl = "http://10.0.2.2/flutter_api/new_connection.php";
      }

      var uri = Uri.parse(apiUrl);

      var request = http.MultipartRequest("POST", uri);

      request.fields['full_name'] = nameController.text.trim();
      request.fields['age'] = ageController.text.trim();
      request.fields['phone'] = phoneController.text.trim();
      request.fields['address'] = addressController.text.trim();
      request.fields['aadhaar_number'] = aadharController.text.trim();

      if (kIsWeb && webImageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'aadhaar_image',
            webImageBytes!,
            filename: 'aadhaar.png',
          ),
        );
      } else if (aadharFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'aadhaar_image',
            aadharFile!.path,
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      if (data['status'] == true) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (_) => CommonSuccessPage(
              title: "Application Submitted!",
              message:
                  "Your new gas connection request has been submitted successfully.\nOur team will contact you soon.",
              onDone: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              },
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "New Connection Apply",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                          final age = int.tryParse(v!.trim());
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
                        validator: (v) => v != null && v.trim().length == 10
                            ? null
                            : "Invalid phone number",
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
                        validator: (v) => v != null && v.trim().length == 12
                            ? null
                            : "Invalid Aadhaar number",
                      ),

                      const SizedBox(height: 20),

                      // ================= UPLOAD =================
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
                            kIsWeb
                                ? (webImageBytes != null
                                    ? Image.memory(webImageBytes!, height: 160)
                                    : const Text("No file selected"))
                                : (aadharFile != null
                                    ? Image.file(aadharFile!, height: 160)
                                    : const Text("No file selected")),
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

                      // ================= SUBMIT =================
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFD5000),
        onTap: (i) {
          if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ================= FIELD =================
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
        validator: validator ??
            (v) => v == null || v.trim().isEmpty ? "Enter $label" : null,
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
