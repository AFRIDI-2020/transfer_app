// To parse this JSON data, do
//
//     final transactionCreateInfo = transactionCreateInfoFromJson(jsonString);

import 'dart:convert';

import 'package:transfer/models/receiver.dart';

TransactionCreateInfo transactionCreateInfoFromJson(String str) => TransactionCreateInfo.fromJson(json.decode(str));

String transactionCreateInfoToJson(TransactionCreateInfo data) => json.encode(data.toJson());

class TransactionCreateInfo {
  Verification? verification;
  List<Receiver>? sender;
  List<Receiver>? receiver;

  TransactionCreateInfo({
    this.verification,
    this.sender,
    this.receiver,
  });

  TransactionCreateInfo copyWith({
    Verification? verification,
    List<Receiver>? sender,
    List<Receiver>? receiver,
  }) =>
      TransactionCreateInfo(
        verification: verification ?? this.verification,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
      );

  factory TransactionCreateInfo.fromJson(Map<String, dynamic> json) => TransactionCreateInfo(
    verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
    sender: json["sender"] == null ? [] : List<Receiver>.from(json["sender"]!.map((x) => Receiver.fromJson(x))),
    receiver: json["receiver"] == null ? [] : List<Receiver>.from(json["receiver"]!.map((x) => Receiver.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "verification": verification?.toJson(),
    "sender": sender == null ? [] : List<dynamic>.from(sender!.map((x) => x.toJson())),
    "receiver": receiver == null ? [] : List<dynamic>.from(receiver!.map((x) => x.toJson())),
  };
}



class Verification {
  int? id;
  String? type;
  String? message;
  int? status;
  DateTime? createdAt;

  Verification({
    this.id,
    this.type,
    this.message,
    this.status,
    this.createdAt,
  });

  Verification copyWith({
    int? id,
    String? type,
    String? message,
    int? status,
    DateTime? createdAt,
  }) =>
      Verification(
        id: id ?? this.id,
        type: type ?? this.type,
        message: message ?? this.message,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    id: json["id"],
    type: json["type"],
    message: json["message"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };
}
