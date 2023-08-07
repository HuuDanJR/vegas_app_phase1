import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {Key? key,
      this.textEditingController,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.prefixIcon,
      this.focusNode,
      this.readOnly = false,
      this.suffixIcon,
      this.suffixIconColor,
      this.onChanged})
      : super(key: key);
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final FocusNode? focusNode;
  final bool? readOnly;
  final void Function(String)? onChanged;
  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Text(
                widget.labelText ?? '',
                style: const TextStyle(color: Colors.black),
              )
            : const SizedBox(),
        Container(
          height: 40.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(6.0)),
          child: TextFormField(
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            obscureText: widget.obscureText!,
            cursorColor: ColorName.primary,
            textInputAction: TextInputAction.done,
            readOnly: widget.readOnly!,
            onTap: () {},
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10.0, left: 10.0),
              iconColor: ColorName.primary,
              fillColor: Colors.white,
              focusColor: ColorName.primary,
              prefixIcon: widget.prefixIcon,
              prefixIconColor: ColorName.primary,
              suffixIcon: widget.suffixIcon,
              suffixIconColor: widget.suffixIconColor,
              // label: Text(
              //   widget.labelText ?? '',
              //   style: TextStyle(fontSize: 18, color: Colors.black),
              // ),
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              floatingLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorName.primary),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorName.primary)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26)),
              // border: OutlineInputBorder(
              //     borderSide: BorderSide(color: Color.fromRGBO(244, 190, 64, 1))),
              floatingLabelBehavior: FloatingLabelBehavior.always,

              hintText: widget.hintText ?? '',
            ),
          ),
        ),
      ],
    );
  }
}

class CustomInputFieldNoLabel extends StatefulWidget {
  const CustomInputFieldNoLabel(
      {Key? key, required this.textEditingController, this.hintText})
      : super(key: key);
  final TextEditingController? textEditingController;
  final String? hintText;
  @override
  _CustomInputFieldNoLabelState createState() =>
      _CustomInputFieldNoLabelState();
}

class _CustomInputFieldNoLabelState extends State<CustomInputFieldNoLabel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 16, color: Colors.black),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers
      controller: widget.textEditingController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 20.0, left: 10.0),
        border: InputBorder.none,
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        // border: OutlineInputBorder(
        //     borderSide: BorderSide(color: Color.fromRGBO(244, 190, 64, 1))),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText ?? '',
      ),
    );
  }
}
