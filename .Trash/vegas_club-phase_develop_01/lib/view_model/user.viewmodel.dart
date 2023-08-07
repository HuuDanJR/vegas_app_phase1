import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/upload_image_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class UserViewmodel extends ChangeNotifier with BaseFunction {
  final repo = Repository();
  Future<void> uploadAvatar(File file,
      {Function(CustomerResponse? customerResponse)? onSuccess}) async {
    try {
      int? customerId = await ProfileUser.getCurrentCustomerId();
      List<UploadImageResponse> response = await repo.uploadImage(file);
      if (response.isNotEmpty) {
        CustomerResponse customerResponse =
            await repo.updateAvatar(customerId, response.first.id!);
        if (onSuccess != null) {
          onSuccess(customerResponse);
        }
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }
}
