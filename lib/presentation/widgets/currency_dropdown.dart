import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/providers/riverpod_providers.dart';

class CurrencyDropdown extends ConsumerWidget {
  final String label;
  final void Function(String?) onChanged;

  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCodesAsync = ref.watch(currencyCodesProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1D212C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: currencyCodesAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
        data: (currencyCodes) {
          final items = currencyCodes.keys.map((code) {
            return DropdownMenuItem<String>(
              value: code,
              child: Text(
                '$code - ${currencyCodes[code]}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList();

          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.grey),
            ),
            dropdownColor: const Color(0xFF1D212C),
            style: const TextStyle(color: Colors.white),
            items: items,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}
