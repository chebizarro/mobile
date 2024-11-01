enum Status {
  active('active'),
  canceled('canceled'),
  canceledByAdmin('canceled_by_admin'),
  settledByAdmin('settled_by_admin'),
  completedByAdmin('completed_by_admin'),
  dispute('dispute'),
  expired('expired'),
  fiatSent('fiat_sent'),
  settledHoldInvoice('settled_hold_invoice'),
  pending('pending'),
  success('success'),
  waitingBuyerInvoice('waiting_buyer_invoice'),
  waitingPayment('waiting_payment'),
  cooperativelyCanceled('cooperatively_canceled');

  final String value;

  const Status(this.value);
}