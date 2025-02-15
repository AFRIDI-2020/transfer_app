// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:transfer/utils/constant_strings.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Token? token;
  User? user;

  LoginResponse({
    this.token,
    this.user,
  });

  LoginResponse copyWith({
    Token? token,
    User? user,
  }) =>
      LoginResponse(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token?.toJson(),
    "user": user?.toJson(),
  };
}

class Token {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  Token({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  Token copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
  }) =>
      Token(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}

class User {
  dynamic headers;
  Original? original;
  dynamic exception;

  User({
    this.headers,
    this.original,
    this.exception,
  });

  User copyWith({
    dynamic headers,
    Original? original,
    dynamic exception,
  }) =>
      User(
        headers: headers ?? this.headers,
        original: original ?? this.original,
        exception: exception ?? this.exception,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    headers: json["headers"],
    original: json["original"] == null ? null : Original.fromJson(json["original"]),
    exception: json["exception"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers,
    "original": original?.toJson(),
    "exception": exception,
  };
}

class Original {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic front;
  dynamic back;
  dynamic own;
  int? approve;
  int? accept;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Original({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.front,
    this.back,
    this.own,
    this.approve,
    this.accept,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Original copyWith({
    int? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    dynamic front,
    dynamic back,
    dynamic own,
    int? approve,
    int? accept,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Original(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        front: front ?? this.front,
        back: back ?? this.back,
        own: own ?? this.own,
        approve: approve ?? this.approve,
        accept: accept ?? this.accept,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Original.fromJson(Map<String, dynamic> json) => Original(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    front: json["front"] == null? null : "$imageUrl${json["front"]}",
    back: json["back"] == null? null : "$imageUrl${json["back"]}",
    own: json["own"] == null? null : "$imageUrl${json["own"]}",
    approve: json["approve"],
    accept: json["accept"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "front": front,
    "back": back,
    "own": own,
    "approve": approve,
    "accept": accept,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'Original{id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, front: $front, back: $back, own: $own, approve: $approve, accept: $accept, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
