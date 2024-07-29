class DecodeUsernameModel {
  final int code;
  final String message;
  final List<QuickToolData>? data;

  DecodeUsernameModel({required this.code, required this.message, this.data});
}

class QuickToolData {
  String? icon;
  String? title;
  String? subtitle;
  String? username;
  String currentOtp;
  int otpExpiresSeconds;

  QuickToolData({
    this.icon,
    this.title,
    this.subtitle,
    this.username,
    this.currentOtp = '',
    this.otpExpiresSeconds = 0,
  });

  factory QuickToolData.fromJson(Map<String, dynamic> json) {
    return QuickToolData(
      icon: json['icon'],
      title: json['title'],
      subtitle: json['subtitle'],
      username: json['username'],
      currentOtp: json['currentOtp'] ?? '',
      otpExpiresSeconds: json['otpExpiresSeconds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'subtitle': subtitle,
      'username': username,
      'currentOtp': currentOtp,
      'otpExpiresSeconds': otpExpiresSeconds,
    };
  }
}
