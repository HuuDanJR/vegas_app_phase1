// To parse this JSON data, do
//
//     final bookingCarRequest = bookingCarRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'booking_car_request.g.dart';

BookingCarRequest bookingCarRequestFromJson(String str) =>
    BookingCarRequest.fromJson(json.decode(str));

String bookingCarRequestToJson(BookingCarRequest data) =>
    json.encode(data.toJson());

@JsonSerializable(includeIfNull: false)
class BookingCarRequest {
  BookingCarRequest(
      {this.customerId,
      this.address,
      this.pickupAt,
      this.customerNote,
      this.currentLocation,
      this.status});
  @JsonKey(name: "current_location")
  String? currentLocation;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "pickup_at")
  String? pickupAt;
  @JsonKey(name: "customer_note")
  String? customerNote;
  @JsonKey(name: "status")
  int? status;

  BookingCarRequest copyWith({
    int? customerId,
    String? address,
    String? pickupAt,
    String? customerNote,
    String? currentLocation,
    int? status,
  }) =>
      BookingCarRequest(
        customerId: customerId ?? this.customerId,
        address: address ?? this.address,
        pickupAt: pickupAt ?? this.pickupAt,
        customerNote: customerNote ?? this.customerNote,
        currentLocation: currentLocation ?? this.currentLocation,
        status: status ?? this.status,
      );

  factory BookingCarRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingCarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookingCarRequestToJson(this);
}
