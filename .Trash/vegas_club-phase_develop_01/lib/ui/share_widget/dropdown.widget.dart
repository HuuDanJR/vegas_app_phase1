import 'package:flutter/material.dart';

class DropdownModel {
  final int? id;
  final String? value;
  final String? display;
  final Widget? widget;

  DropdownModel({this.id, this.value, this.widget, this.display});
}

class DropdownCustomWidget extends StatefulWidget {
  const DropdownCustomWidget({Key? key, required this.listDropdown, this.onChanged})
      : super(key: key);
  final List<DropdownModel>? listDropdown;
  final Function(DropdownModel?)? onChanged;
  @override
  _DropdownCustomWidgetState createState() => _DropdownCustomWidgetState();
}

class _DropdownCustomWidgetState extends State<DropdownCustomWidget> {
  DropdownModel? dropdownModel;

  @override
  void initState() {
    dropdownModel = widget.listDropdown![0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 120.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DropdownModel>(
          value: dropdownModel,
          isDense: true,
          isExpanded: true,
          icon: const SizedBox(),
          // hint: Text('American'),
          items: widget.listDropdown!.map((DropdownModel itemDropdown) {
            return DropdownMenuItem<DropdownModel>(
              value: itemDropdown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemDropdown.widget == null
                      ? const SizedBox()
                      : const Image(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/US_flag_51_stars.svg/1235px-US_flag_51_stars.svg.png"),
                          width: 30.0,
                        ),
                  Text(
                    itemDropdown.display ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropdownModel = value;
              widget.onChanged!(value);
            });
          },
        ),
      ),
    );
  }
}
