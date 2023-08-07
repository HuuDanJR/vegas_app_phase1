import 'dart:developer';

import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/service/authentication.service.dart';

class MixPanelTrackingService {
  Mixpanel? mixpanel;

  Future<void> initMixpanel({Function()? callBack}) async {
    // String tokenMixPanel = dotenv.get("token_mixpanel");
    String tokenMixPanel = boxSetting!.get(mixPanelTokenStore);
    log("=================================================");
    log("token mixpanel: $tokenMixPanel");
    mixpanel = await Mixpanel.init(tokenMixPanel, trackAutomaticEvents: true);
    print(mixpanel);
    log("=================================================");
    if (callBack != null) {
      callBack();
    }
  } //

  Mixpanel? getMixPanel() {
    return mixpanel;
  }

  Future<void> trackData({required String name}) async {
    String enable = boxSetting!.get(enableMixpanelStore);
    var customerResponse = await ProfileUser.getProfileForTracking();

    log("enable tracking $enable");
    if (mixpanel != null && enable == "true") {
      mixpanel!.track(name, properties: customerResponse);
      // Utils().showSnackbar("Send tracking: $name , $properties");
      log("=================================================");
      log("Send tracking: $name , $customerResponse");
      log("=================================================");
    }
  }

  Future<void> identity() async {
    // String identityTmp = await mixpanel!.getDistinctId();
    var customerId = await ProfileUser.getCurrentCustomerId();
    var customer = await ProfileUser.getProfile();
    String enable = boxSetting!.get(enableMixpanelStore);

    if (mixpanel != null && enable == "true") {
      // mixpanel!.identify(customerId.toString());

      mixpanel!.identify(customerId.toString());
      mixpanel!.getPeople().set("Name", customer.getUserName());
      mixpanel!.getPeople().set("\$name", customer.getUserName());
      mixpanel!.getPeople().set("Customer Id", customerId.toString());

      // log("Tracking identiy: $identityTmp");
      // log("Send tracking identity: $identity");
    }
  }

  Future<void> reset() async {
    String enable = boxSetting!.get(enableMixpanelStore);

    if (mixpanel != null && enable == "true") {
      mixpanel!.reset();
      // log("Tracking identiy: $identityTmp");
      // log("Send tracking identity: $identity");
    }
  }
}
