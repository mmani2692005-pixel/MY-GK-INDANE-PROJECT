import 'package:flutter/material.dart';

class AdminDeliveryComplaintViewPage extends StatelessWidget {
  const AdminDeliveryComplaintViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Delivery Complaints",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF6E40),
      ),

      // LIST OF DELIVERY COMPLAINTS
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 8, // demo data
        itemBuilder: (context, index) {
          return _deliveryComplaintTile(context, index);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // DELIVERY COMPLAINT TILE (MODERN)
  // ─────────────────────────────────────────────
  Widget _deliveryComplaintTile(BuildContext context, int index) {
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
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFE0CC),
          child: Icon(Icons.local_shipping, color: Color(0xFFFD5000)),
        ),
        title: Text(
          "Consumer No: 2000$index",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Row(
          children: [
            _StatusChip(text: "Pending"),
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _infoRow(Icons.person, "Name", "User Name $index"),
          _infoRow(Icons.phone, "Phone", "98765432$index"),
          _infoRow(
              Icons.location_on, "Address", "Port Blair, Andaman & Nicobar"),
          _infoRow(Icons.timer, "Delivery Issue",
              "Cylinder not delivered on scheduled date"),
          _infoRow(Icons.date_range, "Booking Date", "12-Jan-2025"),
          const SizedBox(height: 14),

          // ADMIN ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text("Delivered"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Marked as Delivered"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text("Reject"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Complaint Rejected"),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
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
          Icon(icon, size: 20, color: const Color(0xFFFD5000)),
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
  const _StatusChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.orange.shade800,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
