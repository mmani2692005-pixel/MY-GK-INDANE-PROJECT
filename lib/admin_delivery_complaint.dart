import 'package:flutter/material.dart';

class AdminDeliveryComplaintViewPage extends StatelessWidget {
  const AdminDeliveryComplaintViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "Delivery Complaints",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // LIST OF DELIVERY COMPLAINTS
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 8, // demo data
        itemBuilder: (context, index) {
          return _deliveryComplaintTile(context, index);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // DELIVERY COMPLAINT TILE
  // ─────────────────────────────────────────────
  Widget _deliveryComplaintTile(BuildContext context, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.local_shipping,
          color: Color(0xFFFD5000),
        ),
        title: Text(
          "Consumer No: 2000$index",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Status: Pending"),
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
          const SizedBox(height: 10),

          // ADMIN ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.check_circle, color: Colors.green),
                label: const Text("Mark Delivered"),
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
              OutlinedButton.icon(
                icon: const Icon(Icons.close, color: Colors.red),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFFFD5000)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
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
