class GenerateOtpResponse {
  final int code;
  final String status;
  final String message;
  final List<OtpData> data;

  GenerateOtpResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory GenerateOtpResponse.fromJson(Map<String, dynamic> json) {
    dynamic jsonData = json['data'];
    List<OtpData> dataList = [];

    // Check if jsonData is a list
    if (jsonData is List) {
      dataList = jsonData.map((item) => OtpData.fromJson(item)).toList();
    } else if (jsonData is Map<String, dynamic>) {
      // Handle single object case
      dataList.add(OtpData.fromJson(jsonData));
    }

    return GenerateOtpResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: dataList,
    );
  }
}

class OtpData {
  final String username;
  final String otp;
  final int otpExpiresSeconds;

  OtpData({
    required this.username,
    required this.otp,
    required this.otpExpiresSeconds,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      username: json['username'],
      otp: json['otp'],
      otpExpiresSeconds: json['otp_expires_seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'otp': otp,
      'otp_expires_seconds': otpExpiresSeconds,
    };
  }
}
