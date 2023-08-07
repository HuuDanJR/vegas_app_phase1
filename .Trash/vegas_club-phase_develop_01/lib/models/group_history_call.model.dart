import 'package:vegas_club/models/response/history_call_response.dart';

class GroupHistoryCall {
  final String? name;
  final String? dateTime;
  final List<HistoryCallResponse>? listHisCall;

  GroupHistoryCall({this.name, this.dateTime, this.listHisCall});
}
