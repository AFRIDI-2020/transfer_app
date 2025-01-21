// To parse this JSON data, do
//
//     final paymentRequest = paymentRequestFromJson(jsonString);

import 'dart:convert';

PaymentRequest paymentRequestFromJson(String str) => PaymentRequest.fromJson(json.decode(str));

String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());

class PaymentRequest {
  String? sender1;
  String? senderNumber;
  String? receiver1;
  String? receiverNumber;
  String? amount;
  String? net;
  String? trns;
  String? date;

  PaymentRequest({
    this.sender1,
    this.senderNumber,
    this.receiver1,
    this.receiverNumber,
    this.amount,
    this.net,
    this.trns,
    this.date,
  });

  PaymentRequest copyWith({
    String? sender1,
    String? senderNumber,
    String? receiver1,
    String? receiverNumber,
    String? amount,
    String? net,
    String? trns,
    String? date,
  }) =>
      PaymentRequest(
        sender1: sender1 ?? this.sender1,
        senderNumber: senderNumber ?? this.senderNumber,
        receiver1: receiver1 ?? this.receiver1,
        receiverNumber: receiverNumber ?? this.receiverNumber,
        amount: amount ?? this.amount,
        net: net ?? this.net,
        trns: trns ?? this.trns,
        date: date ?? this.date,
      );

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    sender1: json["sender1"],
    senderNumber: json["sender_number"],
    receiver1: json["receiver1"],
    receiverNumber: json["receiver_number"],
    amount: json["amount"],
    net: json["net"],
    trns: json["trns"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "sender1": sender1,
    "sender_number": senderNumber,
    "receiver1": receiver1,
    "receiver_number": receiverNumber,
    "amount": amount,
    "net": net,
    "trns": trns,
    "date": date,
  };
}
