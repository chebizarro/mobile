import 'package:flutter/material.dart';
import 'package:mostro_mobile/app/app_theme.dart';
import 'package:mostro_mobile/features/take_order/widgets/order_app_bar.dart';

class CompletionMessage extends StatelessWidget {
  final String message;

  const CompletionMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark1,
      appBar: OrderAppBar(title: 'Completion'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: AppTheme.cream1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Thank you for using our service!',
                style: TextStyle(color: AppTheme.grey2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mostroGreen,
                ),
                child: const Text('Return to Main Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
