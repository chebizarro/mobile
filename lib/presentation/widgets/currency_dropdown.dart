import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/app/app_theme.dart';
import 'package:mostro_mobile/shared/providers/exchange_service_provider.dart';

class CurrencyDropdown extends ConsumerWidget {
  final String label;

  const CurrencyDropdown({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCodesAsync = ref.watch(currencyCodesProvider);
    final selectedFiatCode = ref.watch(selectedFiatCodeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.dark1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: currencyCodesAsync.when(
        loading: () => const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => Row(
          children: [
            Text('Failed to load currencies'),
            TextButton(
              onPressed: () => ref.refresh(currencyCodesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
        data: (currencyCodes) {
          final items = currencyCodes.keys.map((code) {
            return DropdownMenuItem<String>(
              value: code,
              child: Text(
                '$code - ${currencyCodes[code]}',
                style: const TextStyle(color: AppTheme.cream1),
              ),
            );
          }).toList();

          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              labelStyle: const TextStyle(color: AppTheme.grey2),
            ),
            dropdownColor: AppTheme.dark1,
            style: TextStyle(color: AppTheme.cream1),
            items: items,
            value: selectedFiatCode,
            onChanged: (value) =>
                ref.read(selectedFiatCodeProvider.notifier).state = value,
          );
        },
      ),
    );
  }
}
