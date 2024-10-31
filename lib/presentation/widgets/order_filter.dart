import 'package:flutter/material.dart';
import 'package:mostro_mobile/core/theme/app_theme.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cream1,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.filter_list, color: AppTheme.dark2, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'FILTER',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.dark2,
                    ),
                  ),
                ],
              ),
              Icon(Icons.close, color: AppTheme.dark2, size: 20),
            ],
          ),
          SizedBox(height: 20),
          buildDropdownSection(context, 'Fiat currencies', 'VES, MXN, ARS'),
          buildDropdownSection(context, 'Payment methods', 'REVOLUT, BANK TRANSFER, CASH'),
          buildDropdownSection(context, 'Countries', 'MX, VE, AR, CO, SV'),
          buildDropdownSection(context, 'Rating', '4+'),
        ],
      ),
    );
  }

  Widget buildDropdownSection(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.mostroGreen,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                onChanged: (String? newValue) {},
                items: <String>[value]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppTheme.dark1,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.dark1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
