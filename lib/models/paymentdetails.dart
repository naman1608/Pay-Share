// @dart=2.9
class ParticularPayment {
  int amount;
  String reason;
  int due;
  ParticularPayment(this.amount, this.reason, this.due);
}

class PaymentDetails {
  String payee;
  List<ParticularPayment> paymentdetails;
  int sum;
  PaymentDetails(this.payee, this.paymentdetails, this.sum);
}
