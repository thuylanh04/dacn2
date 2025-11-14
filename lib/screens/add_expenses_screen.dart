// Screen: AddExpensesScreen
// Form to add a transport expense (placeholder navigation back on Save).

import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  late TextEditingController _dateController;
  late TextEditingController _categoryController;
  late TextEditingController _amountController;
  late TextEditingController _titleController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: 'March 30, 2024');
    _categoryController = TextEditingController();
    _amountController = TextEditingController(text: '\$3.53');
    _titleController = TextEditingController(text: 'Fuel');
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _categoryController.dispose();
    _amountController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF14C996);

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Add Expenses',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Date'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _dateController,
                      placeholder: 'Select date',
                      suffix: Icons.calendar_today,
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Category'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _categoryController,
                      placeholder: 'Select the category',
                      suffix: Icons.expand_more,
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Amount'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _amountController,
                      placeholder: '\$0.00',
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Expense Title'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _titleController,
                      placeholder: 'Enter title',
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Enter Message'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: 'Enter Message',
                          hintStyle: TextStyle(
                            color: Color(0xFF14C996),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    IconData? suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(
            color: Color(0xFF14C996),
            fontSize: 14,
          ),
          border: InputBorder.none,
          suffixIcon: suffix != null
              ? Icon(suffix, color: const Color(0xFF14C996), size: 20)
              : null,
        ),
      ),
    );
  }
}
