// To parse this JSON data, do
//
//     final transactionHistoryItemModel = transactionHistoryItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:transfer/models/receiver.dart';

TransactionHistoryItemModel transactionHistoryItemModelFromJson(String str) => TransactionHistoryItemModel.fromJson(json.decode(str));

String transactionHistoryItemModelToJson(TransactionHistoryItemModel data) => json.encode(data.toJson());

class TransactionHistoryItemModel {
  int? id;
  String? uuid;
  Receiver? sender;
  String? senderNumber;
  Receiver? receiver;
  String? receiverNumber;
  String? type;
  String? amount;
  String? taka;
  String? netTaka;
  String? senderTranId;
  String? timeDate;
  String? status;
  dynamic paidDate;
  dynamic paidAmount;
  dynamic by;
  dynamic ourTranId;
  dynamic ourTransStatus;
  dynamic statusUpdateTime;
  dynamic narration;
  String? archive;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  String? sendingType;
  String? sendingNumber;
  String? stage;
  String? stageBy;
  dynamic gatewayTrns;

  TransactionHistoryItemModel({
    this.id,
    this.uuid,
    this.sender,
    this.senderNumber,
    this.receiver,
    this.receiverNumber,
    this.type,
    this.amount,
    this.taka,
    this.netTaka,
    this.senderTranId,
    this.timeDate,
    this.status,
    this.paidDate,
    this.paidAmount,
    this.by,
    this.ourTranId,
    this.ourTransStatus,
    this.statusUpdateTime,
    this.narration,
    this.archive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.sendingType,
    this.sendingNumber,
    this.stage,
    this.stageBy,
    this.gatewayTrns,
  });

  TransactionHistoryItemModel copyWith({
    int? id,
    String? uuid,
    Receiver? sender,
    String? senderNumber,
    Receiver? receiver,
    String? receiverNumber,
    String? type,
    String? amount,
    String? taka,
    String? netTaka,
    String? senderTranId,
    String? timeDate,
    String? status,
    dynamic paidDate,
    dynamic paidAmount,
    dynamic by,
    dynamic ourTranId,
    dynamic ourTransStatus,
    dynamic statusUpdateTime,
    dynamic narration,
    String? archive,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    String? sendingType,
    String? sendingNumber,
    String? stage,
    String? stageBy,
    dynamic gatewayTrns,
  }) =>
      TransactionHistoryItemModel(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        sender: sender ?? this.sender,
        senderNumber: senderNumber ?? this.senderNumber,
        receiver: receiver ?? this.receiver,
        receiverNumber: receiverNumber ?? this.receiverNumber,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        taka: taka ?? this.taka,
        netTaka: netTaka ?? this.netTaka,
        senderTranId: senderTranId ?? this.senderTranId,
        timeDate: timeDate ?? this.timeDate,
        status: status ?? this.status,
        paidDate: paidDate ?? this.paidDate,
        paidAmount: paidAmount ?? this.paidAmount,
        by: by ?? this.by,
        ourTranId: ourTranId ?? this.ourTranId,
        ourTransStatus: ourTransStatus ?? this.ourTransStatus,
        statusUpdateTime: statusUpdateTime ?? this.statusUpdateTime,
        narration: narration ?? this.narration,
        archive: archive ?? this.archive,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        sendingType: sendingType ?? this.sendingType,
        sendingNumber: sendingNumber ?? this.sendingNumber,
        stage: stage ?? this.stage,
        stageBy: stageBy ?? this.stageBy,
        gatewayTrns: gatewayTrns ?? this.gatewayTrns,
      );

  factory TransactionHistoryItemModel.fromJson(Map<String, dynamic> json) => TransactionHistoryItemModel(
    id: json["id"],
    uuid: json["uuid"],
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    senderNumber: json["sender_number"],
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    receiverNumber: json["receiver_number"],
    type: json["type"],
    amount: json["amount"],
    taka: json["taka"],
    netTaka: json["net_taka"],
    senderTranId: json["sender_tran_id"],
    timeDate: json["time_date"],
    status: json["status"],
    paidDate: json["paid_date"],
    paidAmount: json["paid_amount"],
    by: json["by"],
    ourTranId: json["our_tran_id"],
    ourTransStatus: json["our_trans_status"],
    statusUpdateTime: json["status_update_time"],
    narration: json["narration"],
    archive: json["archive"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    sendingType: json["sending_type"],
    sendingNumber: json["sending_number"],
    stage: json["stage"],
    stageBy: json["stage_by"],
    gatewayTrns: json["gateway_trns"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "sender": sender?.toJson(),
    "sender_number": senderNumber,
    "receiver": receiver?.toJson(),
    "receiver_number": receiverNumber,
    "type": type,
    "amount": amount,
    "taka": taka,
    "net_taka": netTaka,
    "sender_tran_id": senderTranId,
    "time_date": timeDate,
    "status": status,
    "paid_date": paidDate,
    "paid_amount": paidAmount,
    "by": by,
    "our_tran_id": ourTranId,
    "our_trans_status": ourTransStatus,
    "status_update_time": statusUpdateTime,
    "narration": narration,
    "archive": archive,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "sending_type": sendingType,
    "sending_number": sendingNumber,
    "stage": stage,
    "stage_by": stageBy,
    "gateway_trns": gatewayTrns,
  };
}


