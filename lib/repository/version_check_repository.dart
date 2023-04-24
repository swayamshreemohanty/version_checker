import 'dart:io';
import 'package:dio/dio.dart';
import 'package:version_checker/model/application_version_checker_model.dart';

class VersionCheckRepository {
  VersionCheckRepository();

  Future<ApplicationVersionCheckerModel> checkApplicationVersion({
    required String applicationVersion,
    required String url,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "app_version": applicationVersion,
        "device_type": Platform.isAndroid ? "android" : "ios",
      });
      return await Dio().post('$url/version_check', data: data).then((response) {
        if (response.data['status'] == "valid") {
          return ApplicationVersionCheckerModel.fromMap(response.data['data']);
        } else {
          throw (response.data['message']);
        }
      });
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else {
          throw ("Unable to fetch data");
        }
      } else {
        rethrow;
      }
    }
  }
}
