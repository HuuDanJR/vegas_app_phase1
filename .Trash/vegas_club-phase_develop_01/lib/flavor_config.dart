import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class ConfigFlavor {
  static void setUpConfigDev() {
    FlavorConfig(name: "DEV", variables: {
      "baseUrl": dotenv.env['api_dev'],
    });
  }

  static void setUpConfigProd() {
    FlavorConfig(name: "PROD", variables: {
      "baseUrl": dotenv.env['api_prod'],
    });
  }
}
