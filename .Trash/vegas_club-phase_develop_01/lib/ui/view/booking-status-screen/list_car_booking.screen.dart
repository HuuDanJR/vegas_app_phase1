import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/request/booking_car_request.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/shakeText.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:vegas_club/ui/view/booking-status-screen/history_booking.screen.dart';
import 'package:vegas_club/view_model/booking_status.viewmodel.dart';

const kGoogleApiKey = "AIzaSyCFvDyhxNEOHCJWmq5jVR42Hphw2vJgaf0";
var modelBooking =
    StateProvider<ReservationResponse>((ref) => ReservationResponse());
var dateModel = StateProvider<DateTime?>((ref) => null);
var timeModel = StateProvider<TimeOfDay?>((ref) => null);

class ListCarBookingScreen extends StateFullConsumer {
  const ListCarBookingScreen({Key? key}) : super(key: key);
  static const String routeName = "/listCarBooking";
  @override
  _ListCarBookingScreenState createState() => _ListCarBookingScreenState();
}

class _ListCarBookingScreenState extends StateConsumer<ListCarBookingScreen>
    with SingleTickerProviderStateMixin {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  late TextEditingController? _addressController;

  late TextEditingController? _yourLocationController;
  late TextEditingController? _noteController;
  late TextEditingController? _datePickupController;
  final ScrollController _scrollController = ScrollController();
  AnimationController? _animationController;
  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      types: [],
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: "vi",
      strictbounds: true,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "vi")],
    );

    displayPrediction(p!, homeScaffoldKey.currentState!);
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    // scaffold.showSnackBar(
    //   SnackBar(content: Text("${p.description} - $lat/$lng")),
    // );
  }

  void onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState.s(
    //   SnackBar(content: Text(response.errorMessage!)),
    // );
    // log(response.errorMessage!);
  }

  Future<void> _selectDate() async {
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
      ref.read(dateModel.notifier).state = picked;
      _selectTimeOfDate();
    }
  }

  Future<void> _selectTimeOfDate() async {
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
      ref.read(timeModel.notifier).state = picked;
      var dateSelected = ref.watch(dateModel);
      var timeSelected = ref.watch(timeModel);
      if (dateSelected != null && timeSelected != null) {
        DateTime pickTimeDate = DateTime(dateSelected.year, dateSelected.month,
            dateSelected.day, timeSelected.hour, timeSelected.minute);
        print(pickTimeDate.difference(DateTime.now()).inMinutes);
        if (pickTimeDate.difference(DateTime.now()).inMinutes < -29) {
          showAlertDialog(
              title: "Wrong format date, please try again!",
              typeDialog: TypeDialog.warning,
              onClose: () {
                pop();
              });
        } else {
          _datePickupController!.text = pickTimeDate.toDateString();
        }
      }
    }
  }

  @override
  void initStateWidget() {
    _addressController = TextEditingController();
    _noteController = TextEditingController();
    _datePickupController = TextEditingController();
    _yourLocationController = TextEditingController(text: "Vegas Club");
    // provider.Provider.of<BookingStatusViewModel>(context, listen: false)
    //     .getGroupHistoryBooking(context, 0);
    provider.Provider.of<BookingStatusViewModel>(context, listen: false)
        .getHistoryBooking(context, 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  void _startAnimation() {
    if (_animationController!.status != AnimationStatus.forward) {
      _animationController!.reset();
      _animationController!.forward();
    }
  }

  @override
  void disposeWidget() {
    _animationController!.dispose();
    _addressController!.dispose();
    _noteController!.dispose();
    _datePickupController!.dispose();
  }

  void _startAnimationOffetToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _startAnimation();
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
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: appBarBottomBar(_scaffoldKey,
              context: context,
              title: "Car Booking",
              actions: [
                InkWell(
                  onTap: () {
                    locator
                        .get<CommonService>()
                        .navigatoToNamedRoute(HistoryBooking.routeName)
                        .then((value) {
                      if (value != null) {
                        ReservationResponse bookingCarRequest = value;
                        ref.read(modelBooking.state).state = bookingCarRequest;
                        _addressController!.text =
                            bookingCarRequest.address ?? '';
                        _noteController!.text =
                            bookingCarRequest.customerNote ?? '';
                        _datePickupController!.text =
                            bookingCarRequest.pickupAt != null
                                ? bookingCarRequest.pickupAt!.toDateString()
                                : 'No data';
                        _yourLocationController!.text =
                            bookingCarRequest.currentLocation ?? '';
                        _startAnimationOffetToTop();
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                  ),
                )
              ], onClose: () {
            ref.read(dateModel.state).state = null;
            ref.read(timeModel.state).state = null;
            pop();
          }),
          body: provider.Consumer<BookingStatusViewModel>(
            builder: (BuildContext context, BookingStatusViewModel model,
                Widget? child) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your location",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          height: isSmallScreen(context) ? 30.0 : null,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: AnimatedBuilder(
                              animation: _animationController!,
                              builder: (context, child) {
                                final sineValue = sin(
                                    3 * 2 * pi * _animationController!.value);
                                return Transform.translate(
                                  offset: Offset(sineValue * 2, 0),
                                  child: TextFormField(
                                    // onTap: _handlePressButton,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(fontSize: 16.0),
                                    controller: _yourLocationController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            bottom: isSmallScreen(context)
                                                ? 16
                                                : 0),
                                        hintText: "Enter Your location",
                                        hintStyle: TextStyle(
                                            fontSize: isSmallScreen(context)
                                                ? 12
                                                : 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                );
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Destination",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          height: isSmallScreen(context) ? 30.0 : null,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: AnimatedBuilder(
                            animation: _animationController!,
                            builder: (context, child) {
                              final sineValue =
                                  sin(3 * 2 * pi * _animationController!.value);

                              return Transform.translate(
                                offset: Offset(sineValue * 2, 0),
                                child: TextFormField(
                                  // onTap: _handlePressButton,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(fontSize: 16.0),
                                  controller: _addressController,
                                  // buildCounter: (context,
                                  //     {required currentLength,
                                  //     required isFocused,
                                  //     maxLength}) {
                                  //   return AnimatedBuilder(
                                  //     animation: _animationController!,
                                  //     builder: (context, child) {
                                  //       return Transform.translate(
                                  //         offset: Offset(_animation!.value, 0.0),
                                  //         child: child,
                                  //       );
                                  //     },
                                  //     child: Text(
                                  //       'ew zx',
                                  //       style: TextStyle(
                                  //         color: Colors.black,
                                  //         height: 0.0,
                                  //       ),
                                  //     ),
                                  //   );
                                  // },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 10.0,
                                          bottom:
                                              isSmallScreen(context) ? 16 : 0),
                                      hintText: "Enter Your Destination",
                                      hintStyle: TextStyle(
                                          fontSize:
                                              isSmallScreen(context) ? 12 : 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Date/Time",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          height: isSmallScreen(context) ? 30.0 : null,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            // onTap: _handlePressButton,
                            style: const TextStyle(fontSize: 16.0),
                            textInputAction: TextInputAction.done,
                            controller: _datePickupController,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectDate();
                                    },
                                    child: const Icon(Icons.calendar_month)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 14.0,
                                    bottom: isSmallScreen(context) ? 10 : 0),
                                hintText: "Pick calendar",
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Note",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          height: isSmallScreen(context) ? 70.0 : null,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            // onTap: _handlePressButton,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 16.0),
                            controller: _noteController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 10.0, top: 10.0),
                                hintText: "Enter Note For Driver",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: SizedBox(
                            width: isSmallScreen(context) ? 150 : 200,
                            height: isSmallScreen(context) ? 30 : 40,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorName.primary2)),
                                onPressed: () async {
                                  var dateSelected = ref.watch(dateModel);
                                  var timeSelected = ref.watch(timeModel);
                                  if (_datePickupController!.text.isEmpty) {
                                    showAlertDialog(
                                        title: "Please fill all information!",
                                        typeDialog: TypeDialog.warning,
                                        onClose: () {
                                          pop();
                                        });
                                    return;
                                  }

                                  var customer = await ProfileUser.getProfile();
                                  DateTime dateTmp = DateTime(
                                      dateSelected!.year,
                                      dateSelected.month,
                                      dateSelected.day,
                                      timeSelected!.hour,
                                      timeSelected.minute);
                                  if (dateTmp
                                          .difference(DateTime.now())
                                          .inMinutes <
                                      -29) {
                                    showAlertDialog(
                                        title:
                                            "Wrong format date, please try again!",
                                        typeDialog: TypeDialog.warning,
                                        onClose: () {
                                          pop();
                                        });
                                    return;
                                  }
                                  if (_addressController!.text.isEmpty) {
                                    showAlertDialog(
                                        title:
                                            "Please fill in your address information!",
                                        typeDialog: TypeDialog.warning,
                                        onClose: () {
                                          pop();
                                        });
                                    return;
                                  }

                                  model.postCar(BookingCarRequest(
                                      currentLocation:
                                          _yourLocationController!.text,
                                      address: _addressController!.text,
                                      customerId: customer.id,
                                      status: 1,
                                      customerNote: _noteController!.text,
                                      pickupAt:
                                          _datePickupController!.text.isEmpty
                                              ? DateTime(
                                                      dateSelected.year,
                                                      dateSelected.month,
                                                      dateSelected.day,
                                                      timeSelected.hour,
                                                      timeSelected.minute)
                                                  .toUtc()
                                                  .toString()
                                              : _datePickupController!.text));
                                },
                                child: const Text(
                                  'Booking Request',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamily.quicksand),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "History Booking",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              locator
                                  .get<CommonService>()
                                  .navigatoToNamedRoute(
                                      HistoryBooking.routeName)
                                  .then((value) {
                                if (value != null) {
                                  ReservationResponse bookingCarRequest = value;
                                  ref.read(modelBooking.state).state =
                                      bookingCarRequest;
                                  _addressController!.text =
                                      bookingCarRequest.address ?? '';
                                  _noteController!.text =
                                      bookingCarRequest.customerNote ?? '';
                                  _datePickupController!.text =
                                      bookingCarRequest.pickupAt != null
                                          ? bookingCarRequest.pickupAt!
                                              .toDateString()
                                          : 'No data';
                                  _yourLocationController!.text =
                                      bookingCarRequest.currentLocation ?? '';
                                  ref.read(timeModel.state).state = TimeOfDay(
                                      hour: bookingCarRequest.pickupAt!.hour,
                                      minute:
                                          bookingCarRequest.pickupAt!.minute);
                                  _startAnimationOffetToTop();
                                }
                              });
                            },
                            child: const Text(
                              "View all",
                              style: TextStyle(
                                  color: ColorName.primary2, fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                      provider.Consumer<BookingStatusViewModel>(
                        builder: (BuildContext context,
                            BookingStatusViewModel model, Widget? child) {
                          print(model.listReservation);
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 10.0),
                            itemCount: model.listReservation.length,
                            itemBuilder: (context, index) {
                              return _itemCarBooking(
                                  model.listReservation[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 4,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _itemCarBooking(ReservationResponse reservationResponse) {
    return GestureDetector(
      onTap: () {
        ref.read(modelBooking.state).state = reservationResponse;
        _addressController!.text = reservationResponse.address ?? '';
        _noteController!.text = reservationResponse.customerNote ?? '';
        _yourLocationController!.text =
            reservationResponse.currentLocation ?? '';
        _datePickupController!.text = reservationResponse.pickupAt != null
            ? reservationResponse.pickupAt!.toDateString()
            : 'No data';
        ref.read(dateModel.state).state = reservationResponse.pickupAt;
        ref.read(timeModel.state).state = TimeOfDay(
            hour: reservationResponse.pickupAt!.hour,
            minute: reservationResponse.pickupAt!.minute);
        _startAnimationOffetToTop();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
        child: Row(
          children: [
            const Icon(Icons.car_crash_outlined),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reservationResponse.address ?? "No data",
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Text(
                    reservationResponse.pickupAt != null
                        ? reservationResponse.pickupAt!.toDateString()
                        : 'No data',
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  )
                ],
              ),
            ),
            // Expanded(child: SizedBox()),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
