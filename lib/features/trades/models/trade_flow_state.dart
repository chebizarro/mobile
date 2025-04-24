/// Represents the combined state of a trade based on Order Status and Message Action.
/// This helps determine UI elements like available buttons and display text.
enum TradeFlowState {
  // === Pending/Initial ===
  pendingCanCancel,               // Default pending state, can be cancelled.
  pendingWaitingBuyerInvoice,    // Seller created SELL order, waiting for Buyer to provide invoice.

  // === Active - Buyer is purchasing Sats (BUY Order Flow) ===
  activeBuyerNeedsToPayInvoice,   // Buyer took SELL order, needs to pay Seller's LN invoice.
  activeBuyerNeedsToSendFiat,    // Buyer took SELL order, paid invoice / Seller created BUY order, needs to send Fiat.
  activeBuyerWaitingSellerRelease, // Buyer sent Fiat, waiting for Seller to release Sats.

  // === Active - Seller is selling Sats (SELL Order Flow) ===
  activeSellerWaitingBuyerFiat,  // Seller created SELL order, Buyer took it, Seller waiting for Fiat.
  activeSellerNeedsToRelease,   // Seller received Fiat confirmation, needs to release Sats.

  // === Cooperative Cancellation ===
  coopCancelProposedByMe,         // User initiated cooperative cancel.
  coopCancelProposedByPeer,       // Peer initiated cooperative cancel, user can accept/reject.

  // === Dispute ===
  disputeActive,                  // A dispute is active.

  // === End States ===
  completedNeedsRating,           // Trade successful, waiting for user rating.
  completedDone,                  // Trade successful, rating done or not applicable.
  cancelledGeneric,               // Trade cancelled normally by user or Mostro.
  cancelledByAdmin,               // Trade cancelled by admin.
  coopCancelFinalized,            // Cooperative cancel accepted by both.
  expired,                        // Trade expired.

  // === Error/Unknown ===
  unknown,                        // State cannot be determined or is inconsistent.
}
