// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerResponseAdapter extends TypeAdapter<CustomerResponse> {
  @override
  final int typeId = 2;

  @override
  CustomerResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerResponse(
      id: fields[1] as int?,
      age: fields[2] as int?,
      cardNumber: fields[3] as String?,
      cashlessBalance: fields[4] as int?,
      colour: fields[5] as int?,
      colourHtml: fields[6] as String?,
      compBalance: fields[7] as int?,
      compStatusColour: fields[8] as int?,
      compStatusColourHtml: fields[9] as String?,
      forename: fields[10] as String?,
      freeplayBalance: fields[11] as int?,
      gender: fields[12] as String?,
      hasOnlineAccount: fields[13] as bool?,
      hideCompBalance: fields[14] as bool?,
      isGuest: fields[15] as bool?,
      loyaltyBalance: fields[16] as int?,
      loyaltyPointsAvailable: fields[17] as int?,
      membershipTypeName: fields[18] as String?,
      middleName: fields[19] as String?,
      number: fields[20] as int?,
      playerTierName: fields[21] as String?,
      playerTierShortCode: fields[22] as String?,
      premiumPlayer: fields[23] as bool?,
      surname: fields[24] as String?,
      title: fields[25] as String?,
      validMembership: fields[26] as bool?,
      userId: fields[27] as int?,
      attachmentId: fields[28] as int?,
      membershipLastIssueDate: fields[29] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerResponse obj) {
    writer
      ..writeByte(29)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.cardNumber)
      ..writeByte(4)
      ..write(obj.cashlessBalance)
      ..writeByte(5)
      ..write(obj.colour)
      ..writeByte(6)
      ..write(obj.colourHtml)
      ..writeByte(7)
      ..write(obj.compBalance)
      ..writeByte(8)
      ..write(obj.compStatusColour)
      ..writeByte(9)
      ..write(obj.compStatusColourHtml)
      ..writeByte(10)
      ..write(obj.forename)
      ..writeByte(11)
      ..write(obj.freeplayBalance)
      ..writeByte(12)
      ..write(obj.gender)
      ..writeByte(13)
      ..write(obj.hasOnlineAccount)
      ..writeByte(14)
      ..write(obj.hideCompBalance)
      ..writeByte(15)
      ..write(obj.isGuest)
      ..writeByte(16)
      ..write(obj.loyaltyBalance)
      ..writeByte(17)
      ..write(obj.loyaltyPointsAvailable)
      ..writeByte(18)
      ..write(obj.membershipTypeName)
      ..writeByte(19)
      ..write(obj.middleName)
      ..writeByte(20)
      ..write(obj.number)
      ..writeByte(21)
      ..write(obj.playerTierName)
      ..writeByte(22)
      ..write(obj.playerTierShortCode)
      ..writeByte(23)
      ..write(obj.premiumPlayer)
      ..writeByte(24)
      ..write(obj.surname)
      ..writeByte(25)
      ..write(obj.title)
      ..writeByte(26)
      ..write(obj.validMembership)
      ..writeByte(27)
      ..write(obj.userId)
      ..writeByte(28)
      ..write(obj.attachmentId)
      ..writeByte(29)
      ..write(obj.membershipLastIssueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      id: json['id'] as int?,
      age: json['age'] as int?,
      cardNumber: json['card_number'] as String?,
      cashlessBalance: json['cashless_balance'] as int?,
      colour: json['colour'] as int?,
      colourHtml: json['colour_html'] as String?,
      compBalance: json['comp_balance'] as int?,
      compStatusColour: json['comp_status_colour'] as int?,
      compStatusColourHtml: json['comp_status_colour_html'] as String?,
      forename: json['forename'] as String?,
      freeplayBalance: json['freeplay_balance'] as int?,
      gender: json['gender'] as String?,
      hasOnlineAccount: json['has_online_account'] as bool?,
      hideCompBalance: json['hide_comp_balance'] as bool?,
      isGuest: json['is_guest'] as bool?,
      loyaltyBalance: json['loyalty_balance'] as int?,
      loyaltyPointsAvailable: json['loyalty_points_available'] as int?,
      membershipTypeName: json['membership_type_name'] as String?,
      middleName: json['middle_name'] as String?,
      number: json['number'] as int?,
      playerTierName: json['player_tier_name'] as String?,
      playerTierShortCode: json['player_tier_short_code'] as String?,
      premiumPlayer: json['premium_player'] as bool?,
      surname: json['surname'] as String?,
      title: json['title'] as String?,
      validMembership: json['valid_membership'] as bool?,
      userId: json['user_id'] as int?,
      attachmentId: json['attachment_id'] as int?,
      membershipLastIssueDate: json['membership_last_issue_date'] == null
          ? null
          : DateTime.parse(json['membership_last_issue_date'] as String),
      nationality: json['nationality'] as String?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('age', instance.age);
  writeNotNull('card_number', instance.cardNumber);
  writeNotNull('cashless_balance', instance.cashlessBalance);
  writeNotNull('colour', instance.colour);
  writeNotNull('colour_html', instance.colourHtml);
  writeNotNull('comp_balance', instance.compBalance);
  writeNotNull('comp_status_colour', instance.compStatusColour);
  writeNotNull('comp_status_colour_html', instance.compStatusColourHtml);
  writeNotNull('forename', instance.forename);
  writeNotNull('freeplay_balance', instance.freeplayBalance);
  writeNotNull('gender', instance.gender);
  writeNotNull('has_online_account', instance.hasOnlineAccount);
  writeNotNull('hide_comp_balance', instance.hideCompBalance);
  writeNotNull('is_guest', instance.isGuest);
  writeNotNull('loyalty_balance', instance.loyaltyBalance);
  writeNotNull('loyalty_points_available', instance.loyaltyPointsAvailable);
  writeNotNull('membership_type_name', instance.membershipTypeName);
  writeNotNull('middle_name', instance.middleName);
  writeNotNull('number', instance.number);
  writeNotNull('player_tier_name', instance.playerTierName);
  writeNotNull('player_tier_short_code', instance.playerTierShortCode);
  writeNotNull('premium_player', instance.premiumPlayer);
  writeNotNull('surname', instance.surname);
  writeNotNull('title', instance.title);
  writeNotNull('valid_membership', instance.validMembership);
  writeNotNull('user_id', instance.userId);
  writeNotNull('attachment_id', instance.attachmentId);
  writeNotNull('membership_last_issue_date',
      instance.membershipLastIssueDate?.toIso8601String());
  writeNotNull('nationality', instance.nationality);
  return val;
}
