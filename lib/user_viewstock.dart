import 'package:flutter/material.dart';
import 'package:app/adminhome_page.dart'; // Replace with your actual user home page import

class ViewStockPage extends StatefulWidget {
  const ViewStockPage({super.key});

  @override
  State<ViewStockPage> createState() => _ViewStockPageState();
}

class _ViewStockPageState extends State<ViewStockPage> {
  int _selectedIndex = 0;

  // Example data
  final int totalStock = 120;
  final int soldStock = 75;

  void showAdminLoginDialog() {
    TextEditingController passController = TextEditingController();
    bool showPassword = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                            backgroundColor: const Color(0xFFFD5000)),
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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "View Cylinder Stock",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _stockCard(
              title: "Total Cylinders in Godown",
              count: totalStock,
              color: Colors.blueAccent,
              icon: Icons.store,
            ),
            const SizedBox(height: 20),
            _stockCard(
              title: "Cylinders Gone to Sale",
              count: soldStock,
              color: Colors.redAccent,
              icon: Icons.local_shipping,
            ),
            const SizedBox(height: 30),
            Text(
              "Stock Distribution",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: soldStock / totalStock,
              color: Colors.redAccent,
              // ignore: deprecated_member_use
              backgroundColor: Colors.blueAccent.withOpacity(0.3),
              minHeight: 20,
            ),
            const SizedBox(height: 8),
            Text(
              "${((soldStock / totalStock) * 100).toStringAsFixed(1)}% Sold",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
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
            Navigator.pop(context); // Navigate to user home
          }

          if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile page coming soon")),
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

  Widget _stockCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              // ignore: deprecated_member_use
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
