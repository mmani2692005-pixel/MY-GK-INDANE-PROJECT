import 'dart:ui';
import 'package:app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'adminhome_page.dart';
import 'userdefective.dart';
import 'user_newconnection.dart';
import 'user_profile_page.dart';
import 'users_sale&stock.dart';
import 'user_delivery_complaint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarousel = 0;

  final List<String> images = [
    "assets/smart.jpg",
    "assets/cylinder.jpg",
    "assets/indanegas.png",
    "assets/ind.png",
  ];

  // ---------------------------------------------------------------------------
  // ADMIN LOGIN DIALOG (MODERN)
  // ---------------------------------------------------------------------------
  void showAdminLoginDialog() {
    final passController = TextEditingController();
    bool showPass = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              "Admin Access",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextField(
              controller: passController,
              obscureText: !showPass,
              decoration: InputDecoration(
                hintText: "Enter admin password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon:
                      Icon(showPass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => showPass = !showPass),
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
              )
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MAIN UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "GK INDANE SERVICE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFD5000), Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100, bottom: 30),
          child: Column(
            children: [
              // -------------------- CAROUSEL --------------------
              CarouselSlider(
                items: images
                    .map(
                      (img) => ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 190,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (i, _) => setState(() => _currentCarousel = i),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentCarousel == index ? 20 : 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // -------------------- QUICK ACTION GRID --------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _actionCard(
                      icon: Icons.add_box,
                      label: "New Connection",
                      onTap: () => _go(const NewConnectionPage()),
                    ),
                    _actionCard(
                      icon: Icons.layers,
                      label: "Sale & Stock",
                      onTap: () => _go(const ViewSaleAreaPage()),
                    ),
                    _actionCard(
                      icon: Icons.delivery_dining,
                      label: "Delivery Complaint",
                      onTap: () => _go(const DeliveryComplaintPage()),
                    ),
                    _actionCard(
                      icon: Icons.report_problem,
                      label: "Defective Cylinder",
                      onTap: () => _go(const DefectiveCylinderPage()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // -------------------- OFFICE INFO CARD --------------------
              _glassCard(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GK Indane Service",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.location_on, color: Colors.orange),
                      title: Text(
                          "Shop No 1, Fish Market Junglighat\nPort Blair - 744101"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.phone, color: Colors.orange),
                      title: Text("+91 7846018741"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.access_time, color: Colors.orange),
                      title: Text("Closed for the day"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // -------------------- DIRECTIONS --------------------
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Get Directions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _directionTile(
                      title: "GK Indane Office",
                      subtitle: "7M3JMP6H+8R, Port Blair",
                      url:
                          "https://www.google.com/maps/search/?api=1&query=7M3JMP6H+8R",
                    ),
                    _directionTile(
                      title: "GK Indane Godown",
                      subtitle: "Sri Vijaya Puram",
                      url: "https://maps.app.goo.gl/L5bfe6GZCVQdGajh9",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // -------------------- BOTTOM NAV --------------------
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) showAdminLoginDialog();
          if (index == 2) _go(const UserProfilePage());
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: "Admin",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------
  Widget _actionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFFD5000)),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _directionTile({
    required String title,
    required String subtitle,
    required String url,
  }) {
    return ListTile(
      leading: const Icon(Icons.directions, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async {
        final uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not open maps")),
          );
        }
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFD5000)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.local_gas_station,
                      size: 40, color: Color(0xFFFD5000)),
                ),
                SizedBox(height: 10),
                Text(
                  "GK Indane",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text("Admin Login"),
            onTap: showAdminLoginDialog,
          ),
          ListTile(
            leading: const Icon(Icons.layers),
            title: const Text("Sale & Stock"),
            onTap: () => _go(const ViewSaleAreaPage()),
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text("New Connection"),
            onTap: () => _go(const NewConnectionPage()),
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text("Defective Cylinder"),
            onTap: () => _go(const DefectiveCylinderPage()),
          ),
          ListTile(
            leading: const Icon(Icons.delivery_dining),
            title: const Text("Delivery Complaint"),
            onTap: () => _go(const DeliveryComplaintPage()),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () => _go(const UserProfilePage()),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () => _go(const LoginPage()),
          ),
        ],
      ),
    );
  }

  void _go(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
