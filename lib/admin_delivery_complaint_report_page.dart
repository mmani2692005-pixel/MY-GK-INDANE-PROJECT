import 'package:flutter/material.dart';

class AdminDeliveryComplaintReportPage extends StatelessWidget {
  const AdminDeliveryComplaintReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Complaint Report History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),

      // HISTORY LIST
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 6, // demo history data
        itemBuilder: (context, index) {
          return _reportTile(context, index);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // REPORT TILE
  // ─────────────────────────────────────────────
  Widget _reportTile(BuildContext context, int index) {
    final bool isDelivered = index % 2 == 0;

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
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor:
              isDelivered ? Colors.green.shade100 : Colors.red.shade100,
          child: Icon(
            isDelivered ? Icons.check_circle : Icons.cancel,
            color: isDelivered ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          "Consumer No: 2000$index",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            _StatusChip(
              text: isDelivered ? "Delivered" : "Rejected",
              isDelivered: isDelivered,
            ),
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _infoRow(Icons.person, "Name", "User Name $index"),
          _infoRow(Icons.phone, "Phone", "98765432$index"),
          _infoRow(Icons.location_on, "Address",
              "Port Blair, Andaman & Nicobar"),
          _infoRow(Icons.timer, "Issue",
              "Cylinder not delivered on scheduled date"),
          _infoRow(Icons.date_range, "Booking Date", "12-Jan-2025"),
          _infoRow(Icons.event_available, "Closed Date", "15-Jan-2025"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // INFO ROW
  // ─────────────────────────────────────────────
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF4CAF50)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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

// ─────────────────────────────────────────────
// STATUS CHIP
// ─────────────────────────────────────────────
class _StatusChip extends StatelessWidget {
  final String text;
  final bool isDelivered;

  const _StatusChip({
    required this.text,
    required this.isDelivered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDelivered
            ? Colors.green.shade100
            : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isDelivered ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
