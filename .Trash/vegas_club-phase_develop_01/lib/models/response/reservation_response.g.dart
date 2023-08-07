// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationResponse _$ReservationResponseFromJson(Map<String, dynamic> json) =>
    ReservationResponse(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      address: json['address'] as String?,
      pickupAt: json['pickup_at'] == null
          ? null
          : DateTime.parse(json['pickup_at'] as String),
      customerNote: json['customer_note'] as String?,
      bookingType: json['booking_type'] as int?,
      reservationType: json['reservation_type'] as int?,
      driverName: json['driver_name'] as String?,
      driverMobile: json['driver_mobile'] as String?,
      carType: json['car_type'] as String?,
      licensePlate: json['license_plate'] as String?,
      arrivalAt: json['arrival_at'] as String?,
      internalNote: json['internal_note'] as String?,
      price: json['price'] as int?,
      distance: json['distance'] as int?,
      dropOffAt: json['drop_off_at'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      customerResponse: json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      formatDate: json['formatDate'] == null
          ? null
          : DateTime.parse(json['formatDate'] as String),
      currentLocation: json['current_location'] as String?,
    );

Map<String, dynamic> _$ReservationResponseToJson(ReservationResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('address', instance.address);
  writeNotNull('pickup_at', instance.pickupAt?.toIso8601String());
  writeNotNull('customer_note', instance.customerNote);
  writeNotNull('booking_type', instance.bookingType);
  writeNotNull('reservation_type', instance.reservationType);
  writeNotNull('driver_name', instance.driverName);
  writeNotNull('driver_mobile', instance.driverMobile);
  writeNotNull('car_type', instance.carType);
  writeNotNull('license_plate', instance.licensePlate);
  writeNotNull('arrival_at', instance.arrivalAt);
  writeNotNull('internal_note', instance.internalNote);
  writeNotNull('price', instance.price);
  writeNotNull('distance', instance.distance);
  writeNotNull('drop_off_at', instance.dropOffAt);
  writeNotNull('status', instance.status);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('customer', instance.customerResponse);
  writeNotNull('formatDate', instance.formatDate?.toIso8601String());
  writeNotNull('current_location', instance.currentLocation);
  return val;
}
