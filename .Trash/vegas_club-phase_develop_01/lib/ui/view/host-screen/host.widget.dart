import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_club/common/constant/app_language.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/officer_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/view_model/host_screen.viewmodel.dart';

List<String> listLanguageHost = [];

class Host {
  final String? name;
  final List<String>? language;
  final Widget? widget;
  final String? imageUrl;

  Host(this.language, this.widget, this.name, this.imageUrl);
}

Widget itemListLanguage(
    BuildContext context, List<String> listLanguageImageUrl) {
  List<Widget> list = [];
  for (int i = 0; i < listLanguageImageUrl.length; i++) {
    list.add(
      Container(
        width: isSmallScreen(context) ? 18 : 25.0,
        height: isSmallScreen(context) ? 18 : 25.0,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(50)),
        child: ClipOval(
          child: Image.asset(
            listLanguageImageUrl[i],
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  return SizedBox(
      width: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: list));
}

Widget itemHost(
    BuildContext context, OfficerResponse host, HostScreenViewModel model) {
  listLanguageHost = [];
  host.getListLanguage().map((e) {
    listLanguageHost.add(getFlag(e));
  }).toList();
  return GestureDetector(
    onTap: host.online!
        ? () async {
            await model.createHostLine(host.id!);

            if (!await launchUrl(Uri(scheme: 'tel', path: host.phone))) {
              print('Could not launch tel:${host.phone!}');
            }
          }
        : () {},
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: isSmallScreen(context) ? 60 : 85.0,
                height: isSmallScreen(context) ? 60 : 85.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: host.online! ? 4 : 1,
                      color: host.online!
                          ? Colors.green.withOpacity(0.8)
                          : Colors.black38,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(child: avataCircle(host.attachmentId ?? -1)),
                    host.online!
                        ? const SizedBox()
                        : Center(
                            child: ClipOval(
                              child: Container(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Positioned(
                  bottom: -10,
                  left: isSmallScreen(context) ? -10 : 0,
                  child: SizedBox(
                    width: 85.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        itemListLanguage(context, listLanguageHost),
                      ],
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          FittedBox(
            child: Text(
              host.name!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
          ),
          host.online!
              ? Text(
                  "On duty",
                  style: TextStyle(color: Colors.green.withOpacity(0.8)),
                )
              : const Text("Offline")
        ],
      ),
    ),
  );
}
