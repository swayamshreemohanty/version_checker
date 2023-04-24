import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version_checker/repository/version_check_repository.dart';

part 'application_version_checker_state.dart';

class ApplicationVersionCheckerCubit
    extends Cubit<ApplicationVersionCheckerState> {
  ApplicationVersionCheckerCubit() : super(ApplicationVersionCheckingLoading());

  Future<void> checkApplicationVersion({required String url}) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      emit(ApplicationVersionCheckingLoading());
      final versionData =
          await VersionCheckRepository().checkApplicationVersion(
        applicationVersion: packageInfo.version,
        url: url,
      );
      if (versionData.updateRequired) {
        if (versionData.appForceUpdateRequired) {
          emit(CriticalUpdateFound(
            message: versionData.appLatestVersionNote,
            applicationDownloadLink: versionData.appDownloadLink,
          ));
        } else {
          emit(NormalUpdateFound(
            message: versionData.appLatestVersionNote,
            applicationDownloadLink: versionData.appDownloadLink,
          ));
        }
      } else {
        emit(NoUpdateFound());
      }
    } catch (e) {
      emit(ApplicationVersionCheckError(error: e.toString()));
    }
  }

  Future<void> updateApplciation(
      {required String applciationDownloadLink}) async {
    HapticFeedback.lightImpact();
    final url = Uri.parse(applciationDownloadLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Fluttertoast.showToast(
        msg:
            "Unable to open ${Platform.isAndroid ? "Play Store" : "App Store"}",
      );
    }
  }
}
