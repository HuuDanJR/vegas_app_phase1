import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/config/store_setting.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/request/device_request.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'dart:async';

FlutterAppAuth? appAuth = const FlutterAppAuth();
FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class LoginScreenViewModel extends ChangeNotifier with BaseFunction {
  var repo = Repository();

  String jsResult = '';

  String? username;
  String? password;
  CustomerResponse? customerResponse;
  Future<void> initLogin(
    BuildContext context, {
    required VoidCallback onSucess,
    required VoidCallback onFailed,
  }) async {
    try {
      locator
          .get<CommonService>()
          .showAlertDialog(typeDialog: TypeDialog.loading);
      await Future.delayed(const Duration(seconds: 2));
      appAuth = const FlutterAppAuth();
      String? storedRefreshToken = await boxAuth!.get(refressToken);
      print("refresh token: $storedRefreshToken");
      TokenResponse? response;
      if (storedRefreshToken == null) {
        Navigator.of(context).pop();
      } else {
        try {
          response = await appAuth!.token(TokenRequest(
            AUTH0_CLIENT_ID,
            AUTH0_REDIRECT_URI,
            issuer: AUTH0_ISSUER,
            refreshToken: storedRefreshToken,
          ));
          await boxAuth!.put("idToken", response!.idToken!);
          await boxAuth!.put(refressToken, response.refreshToken);
          await boxAuth!.put(accessToken, response.accessToken);
          ProfileUser.storeUser(response.accessToken!);
          print(getUserDetails(response.accessToken!));
          //log token
        } catch (e) {
          Navigator.of(context).pop();
        }

        if (response?.accessToken != null) {
          String? token = await ProfileUser.getAccessToken();
          log("access token :${token!}");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          onSucess();
        }
      }
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
    }
  }

  Map<String, dynamic> getUserDetails(String accessToken) {
    final parts = accessToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<void> getProfile() async {
    CustomerResponse response = await ProfileUser.getProfile();
    customerResponse = response;
    notifyListeners();
  }

// Construct the url

  Future<void> eventLogin(
      {required VoidCallback onSucess, required VoidCallback onFailed}) async {
    try {
      final AuthorizationTokenResponse? result =
          await appAuth!.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI,

          issuer: AUTH0_ISSUER,
          // discoveryUrl: "$AUTH0_ISSUER/.well-known/openid-configuration",
          // preferEphemeralSession: true,
          allowInsecureConnections: true,
          // promptValues: ['login'],
          scopes: ['openid', "read"],
        ),
      );

      if (result != null) {
        StoreConfig.setConfigToStore<bool>(SharePreferenceKey.isFirstLogin, true);

        final idToken = parseIdToken(result.idToken ?? '');
        await boxAuth!.put("idToken", result.idToken);

        await boxAuth!.put(refressToken, result.refreshToken);
        await secureStorage.write(
            key: 'refresh_token', value: result.refreshToken);
        ProfileUser.storeUser(result.accessToken!);
        String? accessToken = await ProfileUser.getAccessToken();
        // log(accessToken!);

        onSucess();
      }
    } catch (e, s) {
      onFailed();
      print('login error: $e - stack: $s');
    }
  }

  Future<void> logout({required VoidCallback onSucess}) async {
    try {
      String deviceToken =
          await locator.get<AuthenticationService>().getDeviceToken();
      try {
        await request(() async {
          await repo.detroyTokenDevice({"token": deviceToken});
        });
      } catch (e) {
        if (e is DioError) {
          print(e.message);
        }
      }
      locator.get<MixPanelTrackingService>().trackData(name: "Đăng xuất");
      locator.get<MixPanelTrackingService>().reset();

      String? token = await ProfileUser.getAccessToken();

      int userId = await ProfileUser.getCurrentUserId();

      await repo.signOut(userId);
      await repo.revokeToken({
        "client_id": AUTH0_CLIENT_ID,
        "client_secret": AUTH0_SECRET_ID,
        "token": token
      });
      await StoreConfig.clearConfigStore();
      onSucess();
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
    }
  }

  Future<void> createTokenDevice(DeviceRequest deviceRequest) async {
    await repo.createTokenDevice(deviceRequest.toJson());
  }
}
