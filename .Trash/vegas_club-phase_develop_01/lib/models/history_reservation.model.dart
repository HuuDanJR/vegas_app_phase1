import 'package:vegas_club/models/response/reservation_response.dart';

class HistoryReservation {
  String? dateTime;
  List<ReservationResponse>? listReservation;
  HistoryReservation({this.dateTime, this.listReservation});
}
