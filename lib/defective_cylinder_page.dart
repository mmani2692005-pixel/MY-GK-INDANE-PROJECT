import 'dart:ui';
import 'package:flutter/material.dart';

// 🔹 IMPORT DEFECTIVE CYLINDER REPORT PAGE
import 'admin_defective_cylinder_report_page.dart';

class AdminDefectiveCylinderViewPage extends StatelessWidget {
  const AdminDefectiveCylinderViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Defective Cylinder Complaints",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // 🔹 HISTORY / REPORT PAGE BUTTON
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "Defective Cylinder Report",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminDefectiveCylinderReportPage(),
                ),
              );
            },
          ),
        ],
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
          itemCount: 8, // demo
          itemBuilder: (context, index) {
            return _complaintCard(context, index);
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // COMPLAINT CARD
  // ---------------------------------------------------------------------------
  Widget _complaintCard(BuildContext context, int index) {
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
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFE0CC),
                child: Icon(Icons.warning, color: Color(0xFFFD5000)),
              ),
              title: Text(
                "Consumer No: 1000$index",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("Port Blair"),
              trailing: _statusChip("Pending"),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _infoRow(Icons.person, "Name", "User Name $index"),
                _infoRow(Icons.phone, "Phone", "98765432$index"),
                _infoRow(Icons.location_on, "Address",
                    "Port Blair, Andaman Islands"),
                _infoRow(Icons.error_outline, "Defect",
                    "Gas leakage near valve area"),
                const SizedBox(height: 16),

                // ---------------- ADMIN ACTIONS ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.close, color: Colors.redAccent),
                      label: const Text("Reject"),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Complaint Rejected"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text("Resolve"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Complaint Resolved"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
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
    Color color = status == "Resolved" ? Colors.green : Colors.orange;

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
