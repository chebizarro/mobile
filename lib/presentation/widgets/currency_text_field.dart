import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mostro_mobile/services/currency_input_formatter.dart';

class CurrencyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CurrencyTextField(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1D212C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          CurrencyInputFormatter(),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
