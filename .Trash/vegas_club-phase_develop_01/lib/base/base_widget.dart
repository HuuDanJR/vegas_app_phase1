import 'package:flutter/material.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/global_constant.dart';

class TextWidget extends StatefulWidget {
  const TextWidget(
      {Key? key,
      required this.text,
      this.style,
      this.textAlign,
      this.softWrap,
      this.overflow,
      this.maxLines,
      this.textWidthBasis})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.translate(context).isEmpty
          ? widget.text
          : widget.text.translate(context),
      style: widget.style,
      textAlign: widget.textAlign,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
    );
  }
}

Widget buttonView(
    {required void Function()? onPressed,
    String? text,
    TextStyle? style,
    Color? backgroundColor,
    double? height,
    double? width,
    bool? isEnable = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        width: width,
        height: height ?? 35,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    backgroundColor ?? ColorName.primary2)),
            onPressed: isEnable! ? onPressed : null,
            child: Text(
              text ?? '',
              style: style ??
                  const TextStyle(
                      color: Colors.white, fontFamily: FontFamily.quicksand),
            )),
      ),
    ),
  );
}

Widget buttonView2(
    {required BuildContext context,
    required void Function()? onPressed,
    String? text,
    Color? color,
    TextStyle? style,
    bool? isEnable = true}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: isSmallScreen(context) ? 100 : 110.0,
      height: isSmallScreen(context) ? 25 : 33.0,
      decoration: BoxDecoration(
          color: color ?? ColorName.primary,
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          text ?? '',
          style: style ?? const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
