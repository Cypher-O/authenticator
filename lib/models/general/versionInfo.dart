class VersionInfoModel {
  final String version;
  final int severity; //0 for compulsory update : 1 for minor update
  final String downloadUrl;

  VersionInfoModel({required this.version, required this.severity, required this.downloadUrl,});

  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    return VersionInfoModel(
      version: json['version'],
      severity: json['severity'],
      downloadUrl: json['downloadUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'severity': severity,
      'downloadUrl': downloadUrl,
    };
  }
}
