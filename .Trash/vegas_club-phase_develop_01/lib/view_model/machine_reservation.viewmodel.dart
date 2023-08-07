import 'package:dio/dio.dart';
import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/machine_neon_response.dart';
import 'package:vegas_club/models/response/machine_playing_response.dart';
import 'package:vegas_club/models/response/machine_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class MachineReservationViewmodel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  int indexSelected = -1;
  List<MachineResponse>? listMachine = [];
  List<MachinePlayResponse> listMachinePlaying = [];

  String machineNumber = "";
  String machineName = "";
  MachineNeonResponse? machineNumerNeon;
  Future<void> getListMachine(int offset) async {
    try {
      if (offset == 0) {
        listMachine = null;
      }
      notifyListeners();
      int? userId = await ProfileUser.getCurrentCustomerId();
      List<MachineResponse> response = [];
      response = await repo.getListMachine(userId, offset, 2);
      if (offset == 0) {
        listMachine = [];
      }
      if (response.isNotEmpty) {
        listMachine!.addAll(response);
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getMachineNeon(int id) async {
    if (id != -1) {
      machineNumerNeon = null;
      MachineNeonResponse? machineNeonResponse = await repo.getMachineNeon(id);
      if (machineNeonResponse.number != -1) {
        machineNumerNeon = machineNeonResponse;
      } else {
        machineNumerNeon = null;
      }
    } else {
      machineNumerNeon = null;
    }
    notifyListeners();
  }

  Future<void> getListMachinePlaying(int offset) async {
    machineNumerNeon = null;
    if (offset == 0) {
      listMachinePlaying = [];
    }
    int? userId = await ProfileUser.getCurrentCustomerId();
    List<MachinePlayResponse> response = [];
    await fetch(() async {
      response = await repo.getMachinePlayingByUserId(userId, offset);
    });
    if (response.isNotEmpty) {
      listMachinePlaying.addAll(response);
    }
    notifyListeners();
  }

  Future<void> requestMachineSlot(Map<String, dynamic> body) async {
    MachineResponse? response;
    await fetch(() async {
      response = await repo.createMachineSlotReservation(body);
    });
    if (response != null) {
      showAlertDialog(
          title: "Request success",
          typeDialog: TypeDialog.success,
          onClose: () {
            pop();
          });
    }
  }

  Future<void> setIndexSelected(int index) async {
    indexSelected = index;
    notifyListeners();
  }

  Future<void> setMachineObject(
      String machineNumberTmp, String machineNameTmp) async {
    machineNumber = machineNumberTmp;
    machineName = machineNameTmp;
    notifyListeners();
  }
}
