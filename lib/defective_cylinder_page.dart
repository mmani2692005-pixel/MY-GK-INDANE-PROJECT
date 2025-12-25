import 'package:flutter/material.dart';

class AdminDefectiveCylinderViewPage extends StatelessWidget {
  const AdminDefectiveCylinderViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text(
          "Defective Cylinder Complaints",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // LIST OF USER COMPLAINTS
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 8, // demo multiple users
        itemBuilder: (context, index) {
          return _complaintTile(context, index);
        },
      ),
    );
  }

  Widget _complaintTile(BuildContext context, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: const Icon(Icons.warning, color: Color(0xFFFD5000)),
        title: Text(
          "Consumer No: 1000$index",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Status: Pending"),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _infoRow(Icons.person, "Name", "User Name $index"),
          _infoRow(Icons.phone, "Phone", "98765432$index"),
          _infoRow(Icons.location_on, "Address", "Port Blair, Andaman Islands"),
          _infoRow(
              Icons.error_outline, "Defect", "Gas leakage near valve area"),
          const SizedBox(height: 10),

          // ADMIN ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.check, color: Colors.green),
                label: const Text("Mark Resolved"),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.close, color: Colors.red),
                label: const Text("Reject"),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

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
