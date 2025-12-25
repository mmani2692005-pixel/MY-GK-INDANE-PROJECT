import 'package:app/adminhome_page.dart';
import 'package:app/userdefective.dart';
import 'package:app/user_newconnection.dart';
import 'package:app/user_profile_page.dart';
import 'package:app/users_salearea.dart';
import 'package:app/user_delivery_complaint.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class IndaneDetails {
  final String address;
  final String landmark;
  final String phone;
  final String status;
  final String plusCode;
  final String fullLocation;

  IndaneDetails({
    required this.address,
    required this.landmark,
    required this.phone,
    required this.status,
    required this.plusCode,
    required this.fullLocation,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      _indaneHomePage(),
    ];
  }

  // ---------------------------------------------------------------------------
  // ⭐ ADMIN LOGIN POPUP
  // ---------------------------------------------------------------------------
  void showAdminLoginDialog() {
    TextEditingController passController = TextEditingController();
    bool showPassword = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
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

  // ---------------------------------------------------------------------------
  // ⭐ MAIN UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    _pages[0] = _indaneHomePage();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "Welcome to My GK Indane !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 3,
              width: 300,
              color: Colors.white,
            ),
          ],
        ),
      ),
      drawer: buildDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFD5000),
              Colors.white,
            ],
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Always highlight Home
        selectedItemColor: const Color(0xFFFD5000),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Home
            setState(() => _selectedIndex = 0);
          } else if (index == 1) {
            // Admin
            showAdminLoginDialog();
          } else if (index == 2) {
            // Profile → PUSH PAGE
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
            icon: Icon(Icons.admin_panel_settings),
            label: "Admin",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ⭐ DRAWER MENU
  // ---------------------------------------------------------------------------
  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFFD5000)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("  Menu!",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xFFFD5000)),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedIndex = 0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Color(0xFFFD5000)),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings,
                      color: Color(0xFFFD5000)),
                  title: const Text("Admin Login"),
                  onTap: () {
                    Navigator.pop(context);
                    showAdminLoginDialog();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report_problem,
                      color: Color(0xFFFD5000)),
                  title: const Text("Defective Cylinder Complaint"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DefectiveCylinderPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_box, color: Color(0xFFFD5000)),
                  title: const Text("New Connection Apply"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NewConnectionPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.layers, color: Color(0xFFFD5000)),
                  title: const Text("Sale & Stock\nUpdates"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ViewSaleAreaPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delivery_dining,
                      color: Color(0xFFFD5000)),
                  title: const Text("Delivery Complaint"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DeliveryComplaintPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ⭐ INDANE HOMEPAGE CONTENT
  // ---------------------------------------------------------------------------
  Widget _indaneHomePage() {
    final List<String> images = [
      "assets/smart.jpg",
      "assets/cylinder.jpg",
      "assets/indanegas.png",
      "assets/ind.png"
    ];

    final indaneInfo = IndaneDetails(
      address: "Shop No 1, Fish Market Junglighat Port Blair - 744101",
      landmark: "Near Van Stand",
      phone: "+917695008500",
      status: "Closed for the day",
      plusCode: "7M3JMP6H+8R",
      fullLocation: "Port Blair, Andaman And Nicobar Islands, India",
    );

    int current = 0;
    final CarouselController controller = CarouselController();

    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),

              CarouselSlider(
                items: images
                    .map(
                      (img) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(img,
                            fit: BoxFit.cover, width: double.infinity),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() => current = index);
                  },
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => controller.animateToPage(entry.key),
                    child: Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == entry.key
                            ? Colors.white
                            // ignore: deprecated_member_use
                            : Colors.white.withOpacity(0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _menuIcon(
                      icon: Icons.add_box,
                      label: "New Connection\nApply",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NewConnectionPage()),
                        );
                      },
                    ),
                    _menuIcon(
                      icon: Icons.layers,
                      label: "Sale & Stock\nUpdates",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ViewSaleAreaPage()),
                        );
                      },
                    ),
                    _menuIcon(
                      icon: Icons.delivery_dining,
                      label: "Delivery\nComplaint",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DeliveryComplaintPage()),
                        );
                      },
                    ),
                    _menuIcon(
                      icon: Icons.report_problem,
                      label: "Defective Cylinder\nComplaint",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DefectiveCylinderPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ORANGE OFFICE DETAILS
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFD5000),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "GK Indane Service",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            indaneInfo.address,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.flag, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(indaneInfo.landmark,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(indaneInfo.phone,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(indaneInfo.status,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ ONE SINGLE WHITE CARD WITH TWO DIRECTIONS
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(20),
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
                      "Get Directions",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    // ---------------------- OFFICE DIRECTION ----------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "📍 GK Indane Office\n7M3JMP6H+8R, Port Blair",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.directions, size: 30),
                          color: Colors.blue,
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(indaneInfo.plusCode)}");

                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Could not open maps.")),
                              );
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Container(height: 1, color: Colors.black12),
                    const SizedBox(height: 12),

                    // ---------------------- GODOWN DIRECTION ----------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "🏭 GK Indane Godown\nHPR9+2P2, Sri Vijaya Puram",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.directions, size: 30),
                          color: Colors.blue,
                          onPressed: () async {
                            final Uri url = Uri.parse(
                              "https://maps.app.goo.gl/L5bfe6GZCVQdGajh9",
                            );

                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Could not open maps.")),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // ⭐ REUSABLE WHITE MENU ICON BOX
  // ---------------------------------------------------------------------------
  Widget _menuIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFFD5000), size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

extension on CarouselController {
  void animateToPage(int key) {}
}
