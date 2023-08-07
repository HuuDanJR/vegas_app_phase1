import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

String baseUrl = "";
// vcms.safeforweb.com/
//product
const AUTH0_DOMAIN = 'mobile.vegasegamingclub.com/';
const AUTH0_CLIENT_ID = 'R6pkcKe02yTVTc6vFABA6CNMcM2zCHJRMCU466T3XPY';
const AUTH0_SECRET_ID = '5WvDZUvQ7x_L8HlbOo23gbywdEqorWlgxdx5WHXAdAo';

const AUTH0_REDIRECT_URI = 'com.trivietjsc.vcms://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
// //

//dev
// const AUTH0_DOMAIN = 'vcms.safeforweb.com/';
// const AUTH0_CLIENT_ID = 'nZRVGK-3JbGkVeEzah_Fqvw0KQ3DoVz6JOuPO0ZbBhU';
// const AUTH0_SECRET_ID = 'ciGz_ccGv7gQRPth1Noh4AJQPxCUao5-0JGs54yvuro';
// const AUTH0_REDIRECT_URI = 'com.trivietjsc.vcms://login-callback';
// const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

//
bool isSmallScreen(BuildContext context) =>
    MediaQuery.of(context).size.width < 380;

//
PackageInfo? packageInfo;
