import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'adminhome_page.dart';
import 'user_profile_page.dart';

class ViewSaleAreaPage extends StatefulWidget {
  const ViewSaleAreaPage({super.key});

  @override
  State<ViewSaleAreaPage> createState() => _ViewSaleAreaPageState();
}

class _ViewSaleAreaPageState extends State<ViewSaleAreaPage> {
  int _selectedIndex = 0;

  // DEMO DATA
  final String date = "06 Jan 2026";
  final int stockCount = 150;
  final String saleArea = "Pema, Calicut, Kamraj Nagar";
  final String inchargeName = "Mr. Mohammed Shafique";
  final String inchargePhone = "+91 7846018731";

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
                  onPressed: () =>
                      setState(() => showPassword = !showPassword),
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
                      MaterialPageRoute(
                          builder: (_) => const AdminHomePage()),
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
  // CALL IN-CHARGE
  // ─────────────────────────────────────────────
  Future<void> _callNumber() async {
    final uri = Uri.parse("tel:$inchargePhone");
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to make call")),
      );
    }
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
          "View stock & Sale Area ",
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
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _infoTile(
                      icon: Icons.calendar_today,
                      title: "Date",
                      value: date,
                    ),
                    _infoTile(
                      icon: Icons.inventory_2,
                      title: "Available Stock",
                      value: "$stockCount Cylinders",
                    ),
                    _infoTile(
                      icon: Icons.map,
                      title: "Today's Sale Area",
                      value: saleArea,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- IN-CHARGE CARD ----------------
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "In-charge Contact",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Icon(Icons.person,
                                  color: Color(0xFFFD5000)),
                              const SizedBox(width: 10),
                              Text(
                                inchargeName,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  color: Color(0xFFFD5000)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  inchargePhone,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.call,
                                    color: Colors.green),
                                onPressed: _callNumber,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "📞 Call in-charge for delivery related issues",
                            style:
                                TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
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
  // INFO TILE
  // ─────────────────────────────────────────────
  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0CC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFFFD5000)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
