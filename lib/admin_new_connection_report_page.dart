import 'dart:ui';
import 'package:flutter/material.dart';

class AdminNewConnectionReportPage extends StatelessWidget {
  const AdminNewConnectionReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "New Connection Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFFDFF5E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
          itemCount: 6, // demo history
          itemBuilder: (context, index) {
            return _reportCard(index);
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // REPORT CARD
  // ---------------------------------------------------------------------------
  Widget _reportCard(int index) {
    final bool isApproved = index % 2 == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(22),
            ),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              leading: CircleAvatar(
                backgroundColor: isApproved
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                child: Icon(
                  isApproved ? Icons.check_circle : Icons.cancel,
                  color: isApproved ? Colors.green : Colors.red,
                ),
              ),
              title: Text(
                "Ramesh Kumar $index",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("Domestic Connection"),
              trailing: _statusChip(
                isApproved ? "Approved" : "Rejected",
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [
                _infoRow(Icons.phone, "Mobile", "98765432$index"),
                _infoRow(Icons.location_on, "Address",
                    "Port Blair, Andaman"),
                _infoRow(Icons.badge, "KYC ID", "AADHAR-XXXX"),
                _infoRow(
                    Icons.business, "Connection Type", "Domestic"),
                _infoRow(Icons.event_available, "Processed Date",
                    "18-Jan-2025"),
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
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
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
          Icon(icon, size: 20, color: Colors.green),
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
                    style:
                        const TextStyle(fontWeight: FontWeight.w600),
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
