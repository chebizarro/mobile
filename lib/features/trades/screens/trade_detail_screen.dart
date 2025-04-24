import 'package:dart_nostr/nostr/model/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:circular_countdown/circular_countdown.dart';

import 'package:mostro_mobile/core/app_theme.dart';
import 'package:mostro_mobile/data/models/enums/role.dart';
import 'package:mostro_mobile/data/models/nostr_event.dart';

import 'package:mostro_mobile/features/order/providers/order_notifier_provider.dart';
import 'package:mostro_mobile/features/order/widgets/order_app_bar.dart';
import 'package:mostro_mobile/features/trades/logic/trade_state_helper.dart';
import 'package:mostro_mobile/features/trades/models/trade_flow_state.dart';
import 'package:mostro_mobile/features/trades/widgets/mostro_message_detail_widget.dart';

import 'package:mostro_mobile/shared/providers/order_repository_provider.dart';
import 'package:mostro_mobile/shared/providers/session_manager_provider.dart';
import 'package:mostro_mobile/shared/providers/session_providers.dart';
import 'package:mostro_mobile/shared/utils/currency_utils.dart';
import 'package:mostro_mobile/shared/widgets/custom_card.dart';

class TradeDetailScreen extends ConsumerWidget {
  final String orderId;
  final TextTheme textTheme = AppTheme.theme.textTheme;

  TradeDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(eventProvider(orderId));
    final session = ref.watch(sessionProvider(orderId));
    final messageAsyncValue = ref.watch(sessionMessagesProvider(orderId));
    final message = messageAsyncValue.when(
      data: (msg) => msg,
      loading: () => null, // Or handle loading state
      error: (err, stack) => null, // Or handle error state
    );

    // Make sure we actually have an order from the provider:
    if (order == null) {
      return const Scaffold(
        backgroundColor: AppTheme.dark1,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.dark1,
      appBar: OrderAppBar(title: 'ORDER DETAILS'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Display basic info about the trade:
            _buildSellerAmount(ref, order),
            const SizedBox(height: 16),
            _buildOrderId(context),
            const SizedBox(height: 16),
            // Detailed info: includes the last Mostro message action text
            MostroMessageDetail(
              order: order,
              message: message,
              userRole: session!.role!,
            ),
            const SizedBox(height: 24),
            _buildCountDownTime(order.expirationDate),
            const SizedBox(height: 36),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: _buildActionButtons(context, ref, order),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a card showing the user is "selling/buying X sats for Y fiat" etc.
  Widget _buildSellerAmount(WidgetRef ref, NostrEvent order) {
    final session = ref.watch(sessionProvider(order.orderId!));

    final selling = session!.role == Role.seller ? 'selling' : 'buying';

    final amountString =
        '${order.fiatAmount} ${order.currency} ${CurrencyUtils.getFlagFromCurrency(order.currency!)}';

    // If `order.amount` is "0", the trade is "at market price"
    final isZeroAmount = (order.amount == '0');
    final satText = isZeroAmount ? '' : ' ${order.amount}';
    final priceText = isZeroAmount ? 'at market price' : '';

    final premium = int.tryParse(order.premium ?? '0') ?? 0;
    final premiumText = premium == 0
        ? ''
        : (premium > 0)
            ? 'with a +$premium% premium'
            : 'with a $premium% discount';

    // Payment method can be multiple, we only display the first for brevity:
    final method = order.paymentMethods.isNotEmpty
        ? order.paymentMethods[0]
        : 'No payment method';

    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              // Using Column with spacing = 2 isn’t standard; using SizedBoxes for spacing is fine.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are $selling$satText sats for $amountString $priceText $premiumText',
                  style: AppTheme.theme.textTheme.bodyLarge,
                  softWrap: true,
                ),
                const SizedBox(height: 16),
                Text(
                  'Created on: ${formatDateTime(order.createdAt!)}',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Payment method: $method',
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Show a card with the order ID that can be copied.
  Widget _buildOrderId(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            orderId,
            style: const TextStyle(color: AppTheme.mostroGreen),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: orderId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order ID copied to clipboard'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            style: IconButton.styleFrom(
              foregroundColor: AppTheme.mostroGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Build a circular countdown to show how many hours are left until expiration.
  Widget _buildCountDownTime(DateTime expiration) {
    // If expiration has passed, the difference is negative => zero.
    final now = DateTime.now();
    final Duration difference =
        expiration.isAfter(now) ? expiration.difference(now) : const Duration();

    // Display hours left
    final hoursLeft = difference.inHours.clamp(0, 9999);
    return Column(
      children: [
        CircularCountdown(
          diameter: 50,
          countdownTotal: 24,
          countdownRemaining: hoursLeft,
          countdownCurrentColor: AppTheme.mostroGreen,
          countdownRemainingColor: Colors.grey,
          textStyle: textTheme.bodySmall!.copyWith(color: AppTheme.cream1),
        ),
        const SizedBox(height: 16),
        Text('Time Left: ${difference.toString().split('.').first}'),
      ],
    );
  }

  /// Main action button area, switching on the determined [TradeFlowState].
  List<Widget> _buildActionButtons(
      BuildContext context, WidgetRef ref, NostrEvent order) {
    // Use the stream provider for the latest message
    final messageAsyncValue = ref.watch(sessionMessagesProvider(orderId));
    final message = messageAsyncValue.when(
      data: (msg) => msg,
      loading: () => null, // Or handle loading state
      error: (err, stack) => null, // Or handle error state
    );
    final session = ref.watch(sessionProvider(orderId));

    // Handle potential null session
    if (session == null) {
      return []; // No session, no actions
    }

    // Determine the unified state using the helper
    final currentState = determineTradeFlowState(
      order: order,
      message: message, // Pass the latest message
      userRole: session.role!, // Pass the user's role (checked for null above)
    );

    // Simplified switch based on the unified TradeFlowState
    switch (currentState) {
      case TradeFlowState.pendingCanCancel:
        return [
          _buildCancelButton(context, ref),
        ];

      case TradeFlowState.pendingWaitingBuyerInvoice:
        // Seller is waiting, Buyer needs to add invoice
        if (session.role == Role.buyer) {
          return [_buildAddInvoiceButton(context)];
        } else {
          return []; // Seller has no action here
        }

      case TradeFlowState.activeBuyerNeedsToPayInvoice:
        // Buyer needs to pay the invoice (Seller shows nothing)
        if (session.role == Role.buyer) {
          return [_buildPayInvoiceButton(context)]; // Corrected arguments
        } else {
          return [];
        }

      case TradeFlowState.activeBuyerNeedsToSendFiat:
        // Buyer needs to confirm they sent fiat (Seller waits)
        if (session.role == Role.buyer) {
          return [_buildFiatSentButton(ref)]; // Corrected arguments
        } else {
          return []; // Seller waits
        }

      case TradeFlowState.activeSellerWaitingBuyerFiat:
        // Seller is waiting for fiat (Buyer needs to send)
        if (session.role == Role.seller) {
          return []; // Seller waits
        } else {
          // Buyer should see the 'Send Fiat' button
          return [_buildFiatSentButton(ref)]; // Corrected arguments
        }

      case TradeFlowState.activeBuyerWaitingSellerRelease:
        // Buyer waiting for release (Seller needs to release)
        if (session.role == Role.buyer) {
          return []; // Buyer waits
        } else {
          return [_buildReleaseFundsButton(context, ref)];
        }

      case TradeFlowState.activeSellerNeedsToRelease:
        // Seller needs to release (Buyer waits)
        if (session.role == Role.seller) {
          return [_buildReleaseFundsButton(context, ref)];
        } else {
          return []; // Buyer waits
        }

      case TradeFlowState.coopCancelProposedByMe:
        // Waiting for peer response
        return []; // No action needed, just info text

      case TradeFlowState.coopCancelProposedByPeer:
        // User needs to accept/reject
        return [
          _buildAcceptCoopCancelButton(context, ref),
          _buildRejectCoopCancelButton(context, ref),
        ];

      case TradeFlowState.disputeActive:
        return [_buildOpenDisputeButton(context, ref)]; // Or view dispute details?

      case TradeFlowState.completedNeedsRating:
        return [_buildRatePeerButton(context, ref)];

      // Final states - usually no buttons
      case TradeFlowState.completedDone:
      case TradeFlowState.cancelledGeneric:
      case TradeFlowState.cancelledByAdmin:
      case TradeFlowState.coopCancelFinalized:
      case TradeFlowState.expired:
      case TradeFlowState.unknown:
        return []; // No actions for these states
    }
  }

  /// CANCEL
  Widget _buildCancelButton(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(orderNotifierProvider(orderId).notifier);
    return ElevatedButton(
      onPressed: () async {
        await notifier.cancelOrder();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.red1,
      ),
      child: const Text('CANCEL'),
    );
  }

  /// ADD INVOICE
  Widget _buildAddInvoiceButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // TODO: Find or implement AddInvoiceDialog
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AddInvoiceDialog(orderNotifier: orderNotifier);
        //   },
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('ADD INVOICE'),
    );
  }

  /// PAY INVOICE
  Widget _buildPayInvoiceButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () { /* TODO: Add pay invoice logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('PAY INVOICE'),
    );
  }

  /// FIAT_SENT
  Widget _buildFiatSentButton(WidgetRef ref) {
    // Implementation... (Sends 'fiat-sent' action)
    return ElevatedButton(
      onPressed: () { /* TODO: Add fiat sent logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('CONFIRM FIAT SENT'),
    );
  }

  /// RELEASE FUNDS
  Widget _buildReleaseFundsButton(BuildContext context, WidgetRef ref) {
    // Implementation... (Sends 'release' action)
    return ElevatedButton(
      onPressed: () { /* TODO: Add release logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('RELEASE FUNDS'),
    );
  }

  /// ACCEPT CANCEL
  Widget _buildAcceptCoopCancelButton(BuildContext context, WidgetRef ref) {
    // Implementation... (Sends acceptance message)
    return ElevatedButton(
      onPressed: () { /* TODO: Add accept cancel logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('ACCEPT CANCEL'),
    );
  }

  /// REJECT CANCEL
  Widget _buildRejectCoopCancelButton(BuildContext context, WidgetRef ref) {
    // Implementation... (Might just close the dialog or send a rejection message)
    return ElevatedButton(
      onPressed: () { /* TODO: Add reject cancel logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.red1,
      ),
      child: const Text('REJECT CANCEL'),
    );
  }

  /// OPEN DISPUTE
  Widget _buildOpenDisputeButton(BuildContext context, WidgetRef ref) {
    // Implementation... (Sends 'dispute' action or navigates to dispute screen)
    return ElevatedButton(
      onPressed: () { /* TODO: Add dispute logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.red1,
      ),
      child: const Text('OPEN DISPUTE'),
    );
  }

  /// RATE PEER
  Widget _buildRatePeerButton(BuildContext context, WidgetRef ref) {
    // Implementation... (Navigates to rating screen)
    return ElevatedButton(
      onPressed: () { /* TODO: Add rating logic */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.mostroGreen,
      ),
      child: const Text('RATE PEER'),
    );
  }

  /// Format the date time to a user-friendly string with UTC offset
  String formatDateTime(DateTime dt) {
    final dateFormatter = DateFormat('EEE MMM dd yyyy HH:mm:ss');
    final formattedDate = dateFormatter.format(dt);
    final offset = dt.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final timeZoneName = dt.timeZoneName;
    return '$formattedDate GMT $sign$hours$minutes ($timeZoneName)';
  }
}
