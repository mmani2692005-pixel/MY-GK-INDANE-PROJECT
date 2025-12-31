import 'package:flutter/material.dart';

class AdminDefectiveCylinderReportPage extends StatelessWidget {
  const AdminDefectiveCylinderReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Defective Cylinder Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 8, // demo history
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: const Icon(Icons.build, color: Colors.green),
              ),
              title: Text(
                "Consumer No: 1000$index",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: _statusChip("Resolved"),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _infoRow(Icons.person, "Name", "User Name $index"),
                _infoRow(Icons.phone, "Phone", "98765432$index"),
                _infoRow(Icons.location_on, "Address",
                    "Port Blair, Andaman Islands"),
                _infoRow(Icons.error_outline, "Defect",
                    "Gas leakage near valve area"),
                _infoRow(Icons.event_available, "Closed Date", "16-Jan-2025"),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------- INFO ROW ----------------
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold),
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

  // ---------------- STATUS CHIP ----------------
  Widget _statusChip(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
