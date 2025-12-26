import 'package:flutter/material.dart';
import 'package:app/adminhome_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  // ─────────────────────────────────────────────
  // ADMIN LOGIN POPUP
  // ─────────────────────────────────────────────
  void showAdminLoginDialog(BuildContext context) {
    TextEditingController passController = TextEditingController();
    bool showPassword = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
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
                        labelText: "Password",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // 🔶 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "User Profile",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),

      // 🔶 BODY
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔶 HEADER WITH GLASS EFFECT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFD5000), Color(0xFFFFA36C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 72,
                          color: Color(0xFFFD5000),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFFFD5000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Manush Kumar",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Verified User",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🔶 PROFILE DETAILS CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 10,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    children: [
                      Divider(height: 28),
                      ProfileTile(
                        icon: Icons.phone,
                        title: "Phone",
                        value: "+91 98765 43210",
                      ),
                      Divider(height: 28),
                      ProfileTile(
                        icon: Icons.location_on,
                        title: "Address",
                        value: "Port Blair, Andaman & Nicobar",
                      ),
                      Divider(height: 28),
                      
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),

      // 🔶 BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFFFD5000),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            showAdminLoginDialog(context);
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
}

// ─────────────────────────────────────────────
// 🔶 PROFILE TILE (ENHANCED)
// ─────────────────────────────────────────────
class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFD5000), Color(0xFFFFA36C)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
