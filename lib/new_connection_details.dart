import 'dart:ui';
import 'package:flutter/material.dart';

class NewConnectionDetailsAdminPage extends StatelessWidget {
  const NewConnectionDetailsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "New Connection Requests",
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
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
          itemCount: 5, // demo
          itemBuilder: (context, index) {
            return _requestCard(context, index);
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // REQUEST CARD
  // ---------------------------------------------------------------------------
  Widget _requestCard(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(22),
            ),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFE0CC),
                child: Icon(Icons.person, color: Color(0xFFFD5000)),
              ),
              title: const Text(
                "Ramesh Kumar",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("Domestic Connection"),
              trailing: _statusChip("Pending"),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [
                _infoRow(Icons.phone, "Mobile", "9876543210"),
                _infoRow(Icons.location_on, "Address", "Port Blair, Andaman"),
                _infoRow(Icons.badge, "KYC ID", "AADHAR-XXXX"),
                _infoRow(Icons.business, "Connection Type", "Domestic"),
                const SizedBox(height: 16),

                // ---------------- ADMIN ACTIONS ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.close, color: Colors.redAccent),
                      label: const Text("Reject"),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text("Approve"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATUS CHIP
  // ---------------------------------------------------------------------------
  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case "Approved":
        color = Colors.green;
        break;
      case "Rejected":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  // ---------------------------------------------------------------------------
  // INFO ROW
  // ---------------------------------------------------------------------------
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFFFD5000)),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
