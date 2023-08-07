import 'dart:convert';
import 'dart:developer';

import 'package:vegas_club/api/api.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/models/auth.model.dart';
import 'package:vegas_club/models/response/customer_response.dart';

const storageKey = 'STORAGE_KEY';
String storageKeyIdUser = 'STORAGE_KEY_ID_USER';
String currentUser = 'CURRENT_USER';
String accessToken = "ACCESS_TOKEN";
String userInformation = "USER_INFORMATION";
String userId = "USER_ID";
String userCustomer = "USER_CUSTOMER";
String refressToken = "refresh_token";
String deviceToken = "deviceToken";

class AuthenticationService {
  final restClient = locator.get<RestClient>();
  Map<String, dynamic> getUserDetails(String accessToken) {
    final parts = accessToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<void> storeUser(String accessTokenTmp) async {
    final profile = getUserDetails(accessTokenTmp);
    final user = profile.entries.toList()[3].value;
    User authModel = User.fromJson(user);
    await boxAuth!.put(accessToken, accessTokenTmp);
    await boxAuth!.put(userInformation, authModel);

    var userJson = await boxAuth!.get(userInformation);
    CustomerResponse? customerResponse =
        await restClient.getCustomerByUserId(userJson.id!);
    if (customerResponse.id != null) {
      await boxAuth!.put(userCustomer, customerResponse);
      log("user_id: ===> ${customerResponse.id}");
    }
  }

  Future<CustomerResponse> getUser() async {
    final val = await boxAuth!.get(userCustomer);
    CustomerResponse userJson = await boxAuth!.get(userCustomer);

    return userJson;
  }

  Future<void> removeInforCustomer() async {
    await boxAuth!.delete(userCustomer);
  }

  Future<String?> getAccessToken() async {
    String? token = await boxAuth!.get(accessToken);
    return token;
  }

  Future<void> removeAccessToken() async {
    await boxAuth!.delete(accessToken);
  }

  Future<void> removeRefreshToken() async {
    await boxAuth!.delete(refressToken);
  }

  Future<User> getCurrentUser() async {
    User authModel = await boxAuth!.get(userInformation);

    return authModel;
  }

  Future<void> setDevideToken(String value) async {
    await boxAuth!.put(deviceToken, value);
  }

  Future<void> removeDeviceToken() async {
    await boxAuth!.delete(deviceToken);
  }

  Future<String> getDeviceToken() async {
    String? deviceTokenTmp = await boxAuth!.get(deviceToken);
    return deviceTokenTmp ?? '';
  }
}

class ProfileUser {
  static Future<void> storeUser(String result) async {
    return await locator.get<AuthenticationService>().storeUser(result);
  }

  static Future<CustomerResponse> getProfile() async {
    final val = await locator.get<AuthenticationService>().getUser();
    CustomerResponse customerResponse =
        await locator.get<AuthenticationService>().getUser();
    log(json.encode(customerResponse));
    return customerResponse;
  }

  static Future<Map<String, dynamic>> getProfileForTracking() async {
    final val = await locator.get<AuthenticationService>().getUser();
    CustomerResponse customerResponse =
        await locator.get<AuthenticationService>().getUser();
    log(json.encode(customerResponse));
    return customerResponse.toTrackingJson();
  }

  static Future<void> deleteUser() async {
    return await locator.get<AuthenticationService>().removeInforCustomer();
  }

  static Future<String?> getAccessToken() async {
    return await locator.get<AuthenticationService>().getAccessToken();
  }

  static Future<void> removeAccessToken() async {
    await locator.get<AuthenticationService>().removeAccessToken();
  }

  static Future<void> removeRefreshToken() async {
    await locator.get<AuthenticationService>().removeRefreshToken();
  }

  static Future<int> getCurrentCustomerId() async {
    User? authModel =
        await locator.get<AuthenticationService>().getCurrentUser();
    return authModel.customerId!;
  }

  static Future<int> getCurrentUserId() async {
    User? authModel =
        await locator.get<AuthenticationService>().getCurrentUser();
    return authModel.id!;
  }
}
