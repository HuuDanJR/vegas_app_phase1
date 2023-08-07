// To parse this JSON data, do
//
//     final reservationResponse = reservationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/models/response/customer_response.dart';
part 'reservation_response.g.dart';

ReservationResponse reservationResponseFromJson(String str) =>
    ReservationResponse.fromJson(json.decode(str));

String reservationResponseToJson(ReservationResponse data) =>
    json.encode(data.toJson());

@JsonSerializable(includeIfNull: false)
class ReservationResponse {
  ReservationResponse({
    this.id,
    this.customerId,
    this.address,
    this.pickupAt,
    this.customerNote,
    this.bookingType,
    this.reservationType,
    this.driverName,
    this.driverMobile,
    this.carType,
    this.licensePlate,
    this.arrivalAt,
    this.internalNote,
    this.price,
    this.distance,
    this.dropOffAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerResponse,
    this.formatDate,
    this.currentLocation,
  });
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "pickup_at")
  DateTime? pickupAt;
  @JsonKey(name: "customer_note")
  String? customerNote;
  @JsonKey(name: "booking_type")
  int? bookingType;
  @JsonKey(name: "reservation_type")
  int? reservationType;
  @JsonKey(name: "driver_name")
  String? driverName;
  @JsonKey(name: "driver_mobile")
  String? driverMobile;
  @JsonKey(name: "car_type")
  String? carType;
  @JsonKey(name: "license_plate")
  String? licensePlate;
  @JsonKey(name: "arrival_at")
  String? arrivalAt;
  @JsonKey(name: "internal_note")
  String? internalNote;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "distance")
  int? distance;
  @JsonKey(name: "drop_off_at")
  String? dropOffAt;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "customer")
  CustomerResponse? customerResponse;
  DateTime? formatDate;
  @JsonKey(name: "current_location")
  String? currentLocation;
  ReservationResponse copyWith({
    int? id,
    int? customerId,
    String? address,
    DateTime? pickupAt,
    String? customerNote,
    int? bookingType,
    int? reservationType,
    String? driverName,
    String? driverMobile,
    String? carType,
    String? licensePlate,
    String? arrivalAt,
    String? internalNote,
    int? price,
    int? distance,
    String? dropOffAt,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    CustomerResponse? customerResponse,
    DateTime? formatDate,
    String? currentLocation,
  }) =>
      ReservationResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        address: address ?? this.address,
        pickupAt: pickupAt ?? this.pickupAt,
        customerNote: customerNote ?? this.customerNote,
        bookingType: bookingType ?? this.bookingType,
        reservationType: reservationType ?? this.reservationType,
        driverName: driverName ?? this.driverName,
        driverMobile: driverMobile ?? this.driverMobile,
        carType: carType ?? this.carType,
        licensePlate: licensePlate ?? this.licensePlate,
        arrivalAt: arrivalAt ?? this.arrivalAt,
        internalNote: internalNote ?? this.internalNote,
        price: price ?? this.price,
        distance: distance ?? this.distance,
        dropOffAt: dropOffAt ?? this.dropOffAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerResponse: customerResponse ?? this.customerResponse,
        formatDate: formatDate ?? this.formatDate,
        currentLocation: currentLocation ?? this.currentLocation,
      );

  factory ReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationResponseToJson(this);
}
