import 'package:get_it/get_it.dart';
import 'package:vegas_club/api/api.dart';
import 'package:vegas_club/api/app_api.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/service/setting.service.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  // api
  locator.registerSingleton(RestClient(AppApi.createDio(), baseUrl: baseUrl));
  //
  // locator.registerLazySingleton(() => DialogService());
  locator.registerSingleton<CommonService>(CommonService());
  locator.registerSingleton<AuthenticationService>(AuthenticationService());
  locator.registerSingleton<SettingService>(SettingService());
  locator.registerSingleton<MixPanelTrackingService>(MixPanelTrackingService());
}
