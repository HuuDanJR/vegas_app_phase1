// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_car_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCarRequest _$BookingCarRequestFromJson(Map<String, dynamic> json) =>
    BookingCarRequest(
      customerId: json['customer_id'] as int?,
      address: json['address'] as String?,
      pickupAt: json['pickup_at'] as String?,
      customerNote: json['customer_note'] as String?,
      currentLocation: json['current_location'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$BookingCarRequestToJson(BookingCarRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('current_location', instance.currentLocation);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('address', instance.address);
  writeNotNull('pickup_at', instance.pickupAt);
  writeNotNull('customer_note', instance.customerNote);
  writeNotNull('status', instance.status);
  return val;
}
