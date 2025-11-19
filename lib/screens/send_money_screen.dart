// send_money_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_send_button.dart';
import '../widgets/animated_success_message.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedMethod;
  bool _isFavorite = false;
  bool _showSuccess = false;

  final List<String> _paymentMethods = [
    'Bank Transfer',
    'Mobile Money',
    'Credit Card',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Simulate sending
      setState(() {
        _showSuccess = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _showSuccess = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient Name
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Recipient Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Recipient name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Amount
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount *',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid positive amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Payment Method
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Payment Method *',
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedMethod,
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem(value: method, child: Text(method));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a payment method';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Favorite Toggle
              Row(
                children: [
                  const Text('Add to Favorites'),
                  const Spacer(),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Send Button
              Center(child: CustomSendButton(onPressed: _submitForm)),

              const SizedBox(height: 20),

              // Success Message (Animated)
              AnimatedSuccessMessage(visible: _showSuccess),
            ],
          ),
        ),
      ),
    );
  }
}
