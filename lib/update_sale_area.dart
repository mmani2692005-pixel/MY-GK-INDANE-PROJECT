import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateSaleAreaPage extends StatefulWidget {
  const UpdateSaleAreaPage({super.key});

  @override
  State<UpdateSaleAreaPage> createState() => _UpdateSaleAreaPageState();
}

class _UpdateSaleAreaPageState extends State<UpdateSaleAreaPage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat("dd MMM yyyy").format(pickedDate);
      });
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD5000),
        title: const Text("Update Sale Area",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 📅 DATE PICKER FIELD
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: _inputField(
                    "Date",
                    dateController,
                    suffixIcon: Icons.calendar_today,
                  ),
                ),
              ),

              _inputField(
                "Available Stock",
                stockController,
                keyboardType: TextInputType.number,
              ),
              _inputField("Sale Area", areaController),
              _inputField("In-charge Name", nameController),
              _inputField(
                "In-charge Phone",
                phoneController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFD5000),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: _submitData,
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
