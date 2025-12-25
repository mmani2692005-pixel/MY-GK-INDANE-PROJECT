import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/adminhome_page.dart';
import 'package:app/user_profile_page.dart';

class ViewSaleAreaPage extends StatefulWidget {
  const ViewSaleAreaPage({super.key});

  @override
  State<ViewSaleAreaPage> createState() => _ViewSaleAreaPageState();
}

class _ViewSaleAreaPageState extends State<ViewSaleAreaPage> {
  int _selectedIndex = 0;

  // DEMO DATA
  final String date = "16 Dec 2025";
  final int stockCount = 128;
  final String saleArea = "Junglighat, Aberdeen, Dollygunj";
  final String inchargeName = "Mr. Ramesh Kumar";
  final String inchargePhone = "+91 9876543210";

  // ─────────────────────────────────────────────
  // ADMIN LOGIN POPUP
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
                  borderRadius: BorderRadius.circular(16)),
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
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
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
                          child: const Text("Login",
                              style: TextStyle(color: Colors.white)),
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
  // CALL INCHARGE
  // ─────────────────────────────────────────────
  Future<void> _callNumber() async {
    final Uri uri = Uri.parse("tel:$inchargePhone");
    if (!await launchUrl(uri)) {
      // ignore: use_build_context_synchronously
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "View Sale Area",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard(
              icon: Icons.calendar_today,
              title: "Date",
              value: date,
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.inventory,
              title: "Available Stock",
              value: "$stockCount Cylinders",
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.map,
              title: "Today's Sale Area",
              value: saleArea,
            ),
            const SizedBox(height: 25),

            // INCHARGE CONTACT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "In-charge Contact",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Color(0xFFFD5000)),
                      const SizedBox(width: 10),
                      Text(inchargeName, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Color(0xFFFD5000)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(inchargePhone,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: _callNumber,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "📞 Call in-charge if any issue",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // ─────────────────────────────────────────────
      // ⭐ BOTTOM NAVIGATION BAR
      // ─────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFD5000),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            showAdminLoginDialog();
            return;
          }

          setState(() => _selectedIndex = index);

          if (index == 0) {
            Navigator.pop(context); // Home
          }

          if (index == 2) {
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
  // REUSABLE INFO CARD
  // ─────────────────────────────────────────────
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFD5000), size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 5),
                Text(value,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
