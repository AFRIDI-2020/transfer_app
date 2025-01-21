class Receiver {
  int? id;
  String? method;
  String? amount;
  String? type;
  int? sender;
  int? receiver;
  dynamic senderImg;
  dynamic receiverImg;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  String? sendingType;
  String? sendingNumber;
  dynamic gateway;

  Receiver({
    this.id,
    this.method,
    this.amount,
    this.type,
    this.sender,
    this.receiver,
    this.senderImg,
    this.receiverImg,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.sendingType,
    this.sendingNumber,
    this.gateway,
  });

  Receiver copyWith({
    int? id,
    String? method,
    String? amount,
    String? type,
    int? sender,
    int? receiver,
    dynamic senderImg,
    dynamic receiverImg,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    String? sendingType,
    String? sendingNumber,
    dynamic gateway,
  }) =>
      Receiver(
        id: id ?? this.id,
        method: method ?? this.method,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        senderImg: senderImg ?? this.senderImg,
        receiverImg: receiverImg ?? this.receiverImg,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        sendingType: sendingType ?? this.sendingType,
        sendingNumber: sendingNumber ?? this.sendingNumber,
        gateway: gateway ?? this.gateway,
      );

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["id"],
    method: json["method"],
    amount: json["amount"],
    type: json["type"],
    sender: json["sender"],
    receiver: json["receiver"],
    senderImg: json["sender_img"],
    receiverImg: json["receiver_img"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"],
    sendingType: json["sending_type"],
    sendingNumber: json["sending_number"],
    gateway: json["gateway"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method": method,
    "amount": amount,
    "type": type,
    "sender": sender,
    "receiver": receiver,
    "sender_img": senderImg,
    "receiver_img": receiverImg,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "sending_type": sendingType,
    "sending_number": sendingNumber,
    "gateway": gateway,
  };
}