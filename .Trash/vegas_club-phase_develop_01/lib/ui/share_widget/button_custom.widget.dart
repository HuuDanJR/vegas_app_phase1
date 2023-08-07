import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String? text;
  final Function()? onPressed;
  @override
  _CustomButtonWidgetState createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          child: FittedBox(
            child: TextWidget(
              text: widget.text ?? '',
              style: const TextStyle(
                  color: Colors.white, fontFamily: FontFamily.quicksand),
            ),
          )),
    );
  }
}
