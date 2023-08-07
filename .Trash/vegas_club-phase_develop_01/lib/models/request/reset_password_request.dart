// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) =>
    ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) =>
    json.encode(data.toJson());

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.userId,
    this.newPassword,
    this.confirmPassword,
  });

  int? userId;
  String? newPassword;
  String? confirmPassword;

  ResetPasswordRequest copyWith({
    int? userId,
    String? newPassword,
    String? confirmPassword,
  }) =>
      ResetPasswordRequest(
        userId: userId ?? this.userId,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
        userId: json["user_id"],
        newPassword: json["new_password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      };
}
