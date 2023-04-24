class ApplicationVersionCheckerModel {
  ApplicationVersionCheckerModel({
    required this.appLatestVersionNo,
    required this.appLatestVersionNote,
    required this.appDownloadLink,
    required this.appForceUpdateRequired,
    required this.updateRequired,
  });

  final String appLatestVersionNo;
  final String appLatestVersionNote;
  final String appDownloadLink;
  final bool appForceUpdateRequired;
  final bool updateRequired;

  factory ApplicationVersionCheckerModel.fromMap(Map<String, dynamic> json) =>
      ApplicationVersionCheckerModel(
        appLatestVersionNo: json["app_latest_version_no"],
        appLatestVersionNote: json["app_latest_version_note"],
        appDownloadLink: json["app_download_link"],
        appForceUpdateRequired: json["app_force_update_required"] == "yes",
        updateRequired: json["update_required"] == "yes",
      );
}
