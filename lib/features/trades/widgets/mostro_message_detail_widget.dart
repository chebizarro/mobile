import 'package:dart_nostr/nostr/model/event/event.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/data/models/enums/role.dart';
import 'package:mostro_mobile/data/models/mostro_message.dart';
import 'package:mostro_mobile/core/app_theme.dart';

import '../logic/trade_state_helper.dart'; // Import helper

class MostroMessageDetail extends ConsumerWidget {
  final MostroMessage? message;
  final NostrEvent order; // Added parameter
  final Role userRole; // Added parameter

  const MostroMessageDetail({
    super.key,
    required this.message,
    required this.order,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (message == null) {
      // Handle null message case (e.g., show loading or default text)
      return const SizedBox.shrink(); // Or some placeholder
    }

    // Use the helper functions
    final state = determineTradeFlowState(
      order: order,
      message: message,
      userRole: userRole,
    );

    final displayText = getTradeFlowStateDisplayString(
      state: state,
      context: context,
      userRole: userRole,
      order: order,
      message: message,
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.dark2,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATUS UPDATE', // TODO: Localize?
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppTheme.grey),
          ),
          const SizedBox(height: 8.0),
          Text(
            displayText, // Use the text from the helper
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
