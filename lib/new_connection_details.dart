import 'package:flutter/material.dart';

class NewConnectionDetailsAdminPage extends StatelessWidget {
  const NewConnectionDetailsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfd5000),
        title: const Text(
          "New Connection Requests",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: 5, // demo count
          itemBuilder: (context, index) {
            return _requestCard(context, index);
          },
        ),
      ),
    );
  }

  Widget _requestCard(BuildContext context, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(Icons.person, "Applicant Name", "Ramesh Kumar"),
            _row(Icons.phone, "Mobile", "9876543210"),
            _row(Icons.location_on, "Address", "Port Blair, Andaman"),
            _row(Icons.badge, "KYC ID", "AADHAR-XXXX"),
            _row(Icons.business, "Connection Type", "Domestic"),
            const Divider(height: 25),

            // ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status: Pending",
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _actionButton(
                      text: "Approve",
                      color: Colors.green,
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    _actionButton(
                      text: "Reject",
                      color: Colors.red,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFfd5000), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(
                    text: "$title: ",
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

  Widget _actionButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
