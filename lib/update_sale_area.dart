import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateSaleAreaPage extends StatefulWidget {
  const UpdateSaleAreaPage({super.key});

  @override
  State<UpdateSaleAreaPage> createState() => _UpdateSaleAreaPageState();
}

class _UpdateSaleAreaPageState extends State<UpdateSaleAreaPage> {
  final dateController = TextEditingController();
  final stockController = TextEditingController();
  final areaController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      dateController.text = DateFormat("dd MMM yyyy").format(picked);
    }
  }

  void _submitData() {
    if (dateController.text.isEmpty ||
        stockController.text.isEmpty ||
        areaController.text.isEmpty ||
        nameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    Navigator.pop(context, {
      "date": dateController.text,
      "stock": int.parse(stockController.text),
      "area": areaController.text,
      "name": nameController.text,
      "phone": phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Update Sale Area",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 110, 16, 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _dateField(),
                    _input(
                      "Available Stock",
                      stockController,
                      icon: Icons.inventory,
                      keyboard: TextInputType.number,
                    ),
                    _input(
                      "Sale Area",
                      areaController,
                      icon: Icons.location_on,
                    ),
                    _input(
                      "In-charge Name",
                      nameController,
                      icon: Icons.person,
                    ),
                    _input(
                      "In-charge Phone",
                      phoneController,
                      icon: Icons.phone,
                      keyboard: TextInputType.phone,
                    ),
                    const SizedBox(height: 30),

                    // ---------------- BUTTON ----------------
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFD5000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- DATE FIELD ----------------
  Widget _dateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: _input(
          "Date",
          dateController,
          icon: Icons.calendar_today,
        ),
      ),
    );
  }

  // ---------------- INPUT FIELD ----------------
  Widget _input(
    String label,
    TextEditingController controller, {
    IconData? icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
