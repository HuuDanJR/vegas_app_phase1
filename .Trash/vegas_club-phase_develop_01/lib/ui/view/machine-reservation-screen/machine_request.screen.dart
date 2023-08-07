import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/models/request/machine_slot_request.dart';
import 'package:vegas_club/models/response/machine_playing_response.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_reservation.screen.dart';
import 'package:vegas_club/view_model/machine_reservation.viewmodel.dart';

var modelBooking =
    StateProvider<ReservationResponse>((ref) => ReservationResponse());
var dateStartModel = StateProvider<DateTime?>((ref) => null);
var dateEndModel = StateProvider<DateTime?>((ref) => null);

var timeStartModel = StateProvider<TimeOfDay?>((ref) => null);
var timeEndModel = StateProvider<TimeOfDay?>((ref) => null);
var indexSelectedProvider = StateProvider<int>((ref) => -1);

var dateTimeStart = StateProvider<DateTime?>((ref) => null);
var dateTimeEnd = StateProvider<DateTime?>((ref) => null);

class MachineRequestScreen extends StateFullConsumer {
  const MachineRequestScreen({Key? key}) : super(key: key);
  static const String routeName = "/machineRequestScreen";
  @override
  _ListCarBookingScreenState createState() => _ListCarBookingScreenState();
}

class _ListCarBookingScreenState extends StateConsumer<MachineRequestScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController? _addressController;
  late TextEditingController? _noteController;
  late TextEditingController? _timeStartController;
  late TextEditingController? _timeEndController;
  late TextEditingController? _machineNumberController;
  @override
  void initStateWidget() {
    _addressController = TextEditingController();
    _noteController = TextEditingController();
    _timeStartController = TextEditingController();
    _timeEndController = TextEditingController();
    _machineNumberController = TextEditingController();
    provider.Provider.of<MachineReservationViewmodel>(context, listen: false)
        .getListMachinePlaying(0);
  }


  void onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState.s(
    //   SnackBar(content: Text(response.errorMessage!)),
    // );
    log(response.errorMessage!);
  }

  Future<void> _selectDate(
    Function(String? text, DateTime dateTimeCallback) callback,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorName.primary,
              colorScheme: const ColorScheme.light(primary: ColorName.primary)
                  .copyWith(secondary: ColorName.primary),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      ref.read(dateStartModel.state).state = picked;
      _selectTimeOfDate(callback);
    }
  }

  Future<void> _selectTimeOfDate(
      Function(String? p1, DateTime dateTimeCallback) callback) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorName.primary,
              colorScheme: const ColorScheme.light(primary: ColorName.primary)
                  .copyWith(secondary: ColorName.primary),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      // setState(() {
      //   _selectedTimeOfDate = picked;
      // });
      ref.read(timeStartModel.state).state = picked;
      var dateModel = ref.watch(dateStartModel);
      var timeModel = ref.watch(timeStartModel);
      DateTime dateRequest = DateTime(dateModel!.year, dateModel.month,
          dateModel.day, timeModel!.hour, timeModel.minute);
      String dateTimeFinish = Utils.toDateAndTime(dateRequest);
      callback(
          dateTimeFinish,
          DateTime(dateModel.year, dateModel.month, dateModel.day,
              timeModel.hour, timeModel.minute));
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
          // extendBodyBehindAppBar: true,
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: appBarBottomBar(_scaffoldKey,
              context: context,
              title: "Machine Reservation",
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                      onTap: () {
                        pushNamed(MachineReservationScreen.routeName);
                      },
                      child: const SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Icon(Icons.history))),
                )
              ], onClose: () {
            ref.read(dateStartModel.state).state = null;
            ref.read(timeStartModel.state).state = null;
            pop();
          }),
          body: provider.Consumer<MachineReservationViewmodel>(
            builder: (BuildContext context, MachineReservationViewmodel model,
                Widget? child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Time Start",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _timeStartController,
                        readOnly: true,
                        onTap: () {
                          _selectDate((textDate, dateTime) {
                            _timeStartController!.text = textDate ?? '';
                            ref.read(dateTimeStart.state).state = dateTime;
                          });
                        },
                        style: const TextStyle(fontSize: 16.0),
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 15.0, left: 10.0),
                            hintText: "Time start",
                            hintStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorName.primary,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Time End",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _timeEndController,
                        readOnly: true,
                        onTap: () {
                          _selectDate((textDate, dateTime) {
                            _timeEndController!.text = textDate ?? '';
                            ref.read(dateTimeEnd.state).state = dateTime;
                          });
                        },
                        style: const TextStyle(fontSize: 16.0),
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 15.0, left: 10.0),
                            hintText: "Time End",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorName.primary,
                            ),
                            border: InputBorder.none),
                      ),
                    ),

                    // SizedBox(
                    //   height: 50.0,
                    //   width: width(context),
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //         _selectDate();
                    //       },
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Icon(
                    //             Icons.watch_later,
                    //             color: Colors.white,
                    //             size: 16,
                    //           ),
                    //           SizedBox(
                    //             width: 5.0,
                    //           ),
                    //           Text(
                    //             'End',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //           TextFormField(),
                    //         ],
                    //       )),
                    // ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Machine number",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            model.getMachineNeon(-1);
                          } else {
                            model.setMachineObject(value, "");
                            model.getMachineNeon(int.parse(value));
                          }
                        },
                        controller: _machineNumberController,
                        style: const TextStyle(fontSize: 16.0),
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 15.0, left: 10.0),
                            hintText: "Machine number",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                            suffixIcon: SizedBox(),
                            border: InputBorder.none),
                      ),
                    ),
                    model.machineNumerNeon != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Game Theme: ${model.machineNumerNeon?.name ?? ''}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : const SizedBox(
                            height: 25,
                          ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Note",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        // onTap: _handlePressButton,
                        maxLines: 5,
                        controller: _noteController,
                        style: const TextStyle(fontSize: 14.0),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 0.0),
                            hintText: "Enter your note here....",
                            hintStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorName.primary2)),
                              onPressed: () async {
                                if (_timeStartController!.text.isEmpty &&
                                    _timeEndController!.text.isEmpty &&
                                    _noteController!.text.isEmpty) {
                                  showAlertDialog(
                                      title: "Please fill all information!",
                                      typeDialog: TypeDialog.warning,
                                      onClose: () {
                                        pop();
                                      });
                                  return;
                                }
                                int? userId =
                                    await ProfileUser.getCurrentCustomerId();
                                var dateStart = ref.watch(dateTimeStart);
                                var dateEnd = ref.watch(dateTimeEnd);
                                if (dateStart!.isBefore(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    DateTime.now().hour,
                                    DateTime.now().minute))) {
                                  showAlertDialog(
                                      title:
                                          "The start date must be greater than the current date.",
                                      typeDialog: TypeDialog.warning,
                                      onClose: () {
                                        pop();
                                      });
                                  return;
                                }
                                if (dateStart.isAfter(dateEnd!)) {
                                  showAlertDialog(
                                      title:
                                          "The end date must be greater than the start date.",
                                      typeDialog: TypeDialog.warning,
                                      onClose: () {
                                        pop();
                                      });
                                  return;
                                }
                                if (_machineNumberController!.text.isEmpty) {
                                  showAlertDialog(
                                      title: "Machine number is required!",
                                      typeDialog: TypeDialog.warning,
                                      onClose: () {
                                        pop();
                                      });
                                  return;
                                }
                                if (model.machineNumerNeon == null) {
                                  showAlertDialog(
                                      title: "Machine number is not exist!",
                                      typeDialog: TypeDialog.warning,
                                      onClose: () {
                                        pop();
                                      });
                                  return;
                                }
                                model.requestMachineSlot(MachineSlotRequest(
                                  customerId: userId,
                                  machineName:
                                      model.machineNumerNeon?.name ?? '',
                                  machineNumber: int.parse(model.machineNumber),
                                  startedAt: _timeStartController!.text,
                                  endedAt: _timeEndController!.text,
                                  customerNote: _noteController!.text,
                                ).toJson());
                              },
                              child: const Text(
                                'Request',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.quicksand),
                              )),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    model.listMachinePlaying.isNotEmpty
                        ? const Text(
                            'Machine is playing',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          )
                        : const SizedBox(),

                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: GridView.builder(
                      itemCount: model.listMachinePlaying.length,
                      itemBuilder: (context, index) {
                        return _itemSlotMachine(
                            model.listMachinePlaying[index], index, model);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3, crossAxisCount: 2),
                    )),

                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget _itemSlotMachine(
    MachinePlayResponse machine,
    int index,
    MachineReservationViewmodel model,
  ) {
    var selectedIndex = model.indexSelected;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          model.setIndexSelected(index);
          model.setMachineObject(machine.machineNumber!, machine.machineName!);
          _machineNumberController!.text = machine.machineNumber!;
          model.getMachineNeon(int.parse(machine.machineNumber!));
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          height: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: index == selectedIndex
                      ? ColorName.primary2
                      : Colors.white,
                  width: 2)),
          child: SizedBox(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Machine",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        machine.machineNumber.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.icons_ic_poker_card.path,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
