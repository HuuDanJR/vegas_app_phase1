import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/view_model/food_reservation.viewmodel.dart';

class QrScannerScreen extends StateFullConsumer {
  const QrScannerScreen({Key? key}) : super(key: key);
  static const String route = "./QrScanner";
  @override
  StateConsumer<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends StateConsumer<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(
      QRViewController controller, FoodReservationViewmodel model) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      if (result!.code != null) {
        controller.dispose();
        print(result!.code!);
        Provider.of<FoodReservationViewmodel>(context, listen: false)
            .getProductByQrCode(qrCode: result!.code!);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initStateWidget() {
    // TODO: implement initStateWidget
  }

  @override
  void disposeWidget() {
    controller?.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Consumer<FoodReservationViewmodel>(
      builder: (BuildContext context, FoodReservationViewmodel model,
          Widget? child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  pop();
                },
                child: const Icon(Icons.clear)),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: [
              QRView(
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderWidth: 10,
                ),
                key: qrKey,
                onQRViewCreated: (controller) {
                  _onQRViewCreated(controller, model);
                },
              ),
              Positioned(
                bottom: 20.0,
                child: SizedBox(
                  width: width(context),
                  child: const Center(
                    child: Text(
                      'Scan product',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
