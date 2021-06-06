// @dart=2.9
class ParticularPayment {
  int amount;
  String reason;
  int due;
  DateTime date;
  ParticularPayment(this.amount, this.reason, this.due, this.date);
}

class PaymentDetails {
  String payee;
  List<ParticularPayment> paymentdetails;
  int sum;
  PaymentDetails(this.payee, this.paymentdetails, this.sum);
}
