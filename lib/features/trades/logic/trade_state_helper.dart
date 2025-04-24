import 'package:dart_nostr/nostr/model/event/event.dart';
import 'package:mostro_mobile/data/models/enums/action.dart' as mostro_action;
import 'package:mostro_mobile/data/models/enums/role.dart';
import 'package:mostro_mobile/data/models/enums/status.dart';
import 'package:mostro_mobile/data/models/mostro_message.dart';
import 'package:mostro_mobile/data/models/nostr_event.dart';
import 'package:mostro_mobile/features/trades/models/trade_flow_state.dart';
import 'package:flutter/material.dart'; // Needed for BuildContext
import 'package:mostro_mobile/generated/l10n.dart'; // Needed for S
import 'package:mostro_mobile/data/models/order.dart'; // For payload access
import 'package:mostro_mobile/data/models/cant_do.dart'; // For CantDo details
import 'package:mostro_mobile/data/models/dispute.dart'; // For Dispute details

/// Determines the current [TradeFlowState] based on the order details,
/// the latest Mostro message, and the user's role.
TradeFlowState determineTradeFlowState({
  required NostrEvent order,
  required MostroMessage? message, // The latest message for this order
  required Role userRole,
}) {
  // Handle cases where message might be null initially
  final action = message?.action;

  // Logic based on order.status, refined by action and userRole
  switch (order.status) {
    case Status.pending:
      if (action == mostro_action.Action.waitingBuyerInvoice) {
        return TradeFlowState.pendingWaitingBuyerInvoice;
      } else if (action == mostro_action.Action.newOrder || action == null) {
        // Initial state or if message hasn't arrived yet
        return TradeFlowState.pendingCanCancel;
      } else {
        // Other pending actions might imply cancellation is needed
        return TradeFlowState.pendingCanCancel; // Or potentially unknown?
      }

    case Status.waitingPayment:
      if (userRole == Role.buyer) {
        // Buyer took a SELL order, needs to pay the LN invoice
        return TradeFlowState.activeBuyerNeedsToPayInvoice;
      } else {
        // Seller accepted a BUY order, waiting for buyer to pay *them* (via fiat)
        // Note: This might be covered by Status.fiatSent if BUY order flow is different
        // Revisit based on BUY order specifics. Assume fiatSent is the trigger.
        return TradeFlowState.unknown; // Placeholder - Needs clarification for BUY orders
      }

    case Status.waitingBuyerInvoice:
      // Seller is waiting for the buyer to provide an invoice
      if (userRole == Role.seller) {
        return TradeFlowState.pendingWaitingBuyerInvoice;
      }
      // Buyer needs to provide the invoice (handled by action buttons?)
      return TradeFlowState.pendingWaitingBuyerInvoice;

    case Status.active:
    case Status.fiatSent: // Often used when buyer confirms sending fiat
      if (userRole == Role.buyer) {
        // Buyer confirms Fiat Sent
        if (action == mostro_action.Action.fiatSent || order.status == Status.fiatSent) {
           return TradeFlowState.activeBuyerWaitingSellerRelease;
        }
        // Fallback if status is active but action isn't fiatSent yet
        return TradeFlowState.activeBuyerNeedsToSendFiat;
      } else {
        // Seller side
        if (action == mostro_action.Action.fiatSent || order.status == Status.fiatSent) {
          // Seller sees buyer sent fiat, needs to release
          return TradeFlowState.activeSellerNeedsToRelease;
        }
        // Seller waiting for buyer to send fiat
        return TradeFlowState.activeSellerWaitingBuyerFiat;
      }

    case Status.settledHoldInvoice:
      // Seller released funds
      if (userRole == Role.buyer) {
        return TradeFlowState.completedNeedsRating; // Buyer perspective
      } else {
        return TradeFlowState.completedNeedsRating; // Seller perspective
      }

    case Status.success:
      // Could be post-rating
      return TradeFlowState.completedDone;

    case Status.canceled:
      return TradeFlowState.cancelledGeneric;
    case Status.canceledByAdmin:
      return TradeFlowState.cancelledByAdmin;
    case Status.cooperativelyCanceled:
      return TradeFlowState.coopCancelFinalized;
    case Status.expired:
      return TradeFlowState.expired;

    case Status.dispute:
       // Determine specific dispute state based on action?
       if (action == mostro_action.Action.cooperativeCancelInitiatedByPeer) {
         return TradeFlowState.coopCancelProposedByPeer;
       } else if (action == mostro_action.Action.cooperativeCancelInitiatedByYou) {
         return TradeFlowState.coopCancelProposedByMe;
       } else if (action == mostro_action.Action.cooperativeCancelAccepted) {
         return TradeFlowState.coopCancelFinalized;
       }
       // Default dispute state
       return TradeFlowState.disputeActive;

    // TODO: Handle other statuses like settledByAdmin, completedByAdmin, inProgress if necessary
    case Status.settledByAdmin:
    case Status.completedByAdmin:
    case Status.inProgress:
      return TradeFlowState.unknown; }
}

/// Returns the localized display string corresponding to the trade's state.
String getTradeFlowStateDisplayString({
  required TradeFlowState state,
  required BuildContext context,
  required Role userRole,
  required NostrEvent order,
  required MostroMessage? message, // Needed for specific message details (e.g., CantDo reason)
  // TODO: Potentially need access to providers (like expiration times) or pass them in.
}) {
  final S s = S.of(context)!; // Added non-null assertion
  final payload = message?.payload; // Can be Order, CantDo, Dispute, etc.

  // Map TradeFlowState to the appropriate string
  // This replicates the logic from the original MostroMessageDetail widget's switch
  switch (state) {
    case TradeFlowState.pendingCanCancel:
      // Assuming default 'new order' text if pending
      // TODO: Get expiration from config/provider if needed
      return s.newOrder(24); // Placeholder hours

    case TradeFlowState.pendingWaitingBuyerInvoice:
      // TODO: Get expiration from config/provider if needed
       return s.waitingBuyerInvoice(900); // Placeholder seconds

    case TradeFlowState.activeBuyerNeedsToPayInvoice:
      // TODO: Get expiration from config/provider if needed
      if (payload is Order) {
         return s.payInvoice(order.amount as int? ?? 0, order.currency ?? '', payload.fiatAmount , 900); // Placeholder seconds
      } else {
         return s.waitingBuyerInvoice(900); // Fallback
      }

    case TradeFlowState.activeBuyerNeedsToSendFiat:
      // Text often shown when seller is waiting for buyer invoice / buyer needs to add invoice
      // Or when seller confirms buyer invoice and waits for buyer fiat
      // Let's assume the 'add invoice' prompt is more relevant here if buyer
      if (userRole == Role.buyer && payload is Order) {
         // TODO: Get expiration from config/provider if needed
         return s.addInvoice(order.amount as int? ?? 0, order.currency ?? '', payload.fiatAmount, 900); // Placeholder seconds
      } else {
         // Default or seller perspective
         return s.buyerInvoiceAccepted; // Or similar
      }

     case TradeFlowState.activeSellerWaitingBuyerFiat:
        // Seller is waiting for fiat. Display appropriate message.
        if (payload is Order) {
           final peerPubkey = payload.buyerTradePubkey ?? 'peer'; // Placeholder
           return s.buyerTookOrder(peerPubkey, payload.fiatCode, payload.fiatAmount, payload.paymentMethod);
        }
        return "Waiting for buyer's fiat payment"; // Fallback

    case TradeFlowState.activeBuyerWaitingSellerRelease:
      // Buyer confirmed fiat sent.
      final peerPubkey = (payload is Order) ? (payload.sellerTradePubkey ?? 'peer') : 'peer';
      return s.fiatSentOkBuyer(peerPubkey);

    case TradeFlowState.activeSellerNeedsToRelease:
       // Seller sees fiat sent, needs to release.
      final peerPubkey = (payload is Order) ? (payload.buyerTradePubkey ?? 'peer') : 'peer';
      return s.fiatSentOkSeller(peerPubkey);

    case TradeFlowState.coopCancelProposedByMe:
       return s.cooperativeCancelInitiatedByYou(order.orderId!);
    case TradeFlowState.coopCancelProposedByPeer:
       return s.cooperativeCancelInitiatedByPeer(order.orderId!);
    case TradeFlowState.coopCancelFinalized:
      return s.cooperativeCancelAccepted(order.orderId!);

    case TradeFlowState.disputeActive:
       // Check the original action if available
      if (message?.action == mostro_action.Action.disputeInitiatedByPeer && payload is Dispute) {
        return s.disputeInitiatedByPeer(order.orderId!, payload.disputeId);
      } else if (message?.action == mostro_action.Action.disputeInitiatedByYou && payload is Dispute) {
        return s.disputeInitiatedByYou(order.orderId!, payload.disputeId);
      } else if (message?.action == mostro_action.Action.adminTookDispute) {
        return s.adminTookDisputeUsers('admin'); // Placeholder admin
      }
      // Default dispute text
      return "Dispute initiated for order ${order.orderId!}";

    case TradeFlowState.completedNeedsRating:
       // Usually indicates settledHoldInvoice or purchaseCompleted
      if (message?.action == mostro_action.Action.purchaseCompleted) {
         return s.purchaseCompleted;
      } else if (message?.action == mostro_action.Action.holdInvoicePaymentSettled) {
          final peerPubkey = (payload is Order) ? (payload.buyerTradePubkey ?? 'buyer') : 'buyer';
         return s.holdInvoicePaymentSettled(peerPubkey);
      } else if (message?.action == mostro_action.Action.released) {
          final peerPubkey = (payload is Order) ? (payload.sellerTradePubkey ?? 'seller') : 'seller';
          return s.released(peerPubkey);
      }
      // Fallback completion text, prompt for rating
      return s.rate; // Prompt to rate

    case TradeFlowState.completedDone:
       // Could be from 'success' status or 'rateReceived' action
       if (message?.action == mostro_action.Action.rateReceived) {
         return s.rateReceived;
       }
       return s.purchaseCompleted; // Generic completion

    case TradeFlowState.cancelledGeneric:
      if (message?.action == mostro_action.Action.holdInvoicePaymentCanceled) {
        return s.holdInvoicePaymentCanceled;
      }
      return s.canceled(order.orderId!);

    case TradeFlowState.cancelledByAdmin:
      return s.adminCanceledUsers(order.orderId!); // Assuming admin cancel action led here

    case TradeFlowState.expired:
      return "Order Expired"; // TODO: Localize

    case TradeFlowState.unknown:
      // Handle specific 'cant-do' messages if the action was cantDo
      if (message?.action == mostro_action.Action.cantDo && payload is CantDo) {
          // Add cases for CantDoReason mapping to s.invalid... strings
          // Example:
          // switch (payload.cantDoReason) {
          //   case CantDoReason.invalidSignature: return s.invalidSignature;
          //   ...
          // }
          return "Operation Failed: ${payload.cantDoReason.name}"; // Placeholder
      }
       if (message?.action == mostro_action.Action.paymentFailed) {
         return s.paymentFailed('?','?'); // Placeholder attempts/retries
       }
       if (message?.action == mostro_action.Action.adminSettled) {
         return s.adminSettledUsers(order.orderId!); // Although maybe this maps to completed?
       }
       // Default unknown/error
      return "Trade status is currently unknown."; // TODO: Localize
  }
}
