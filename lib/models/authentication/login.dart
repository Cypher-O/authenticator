class ResponseModel {
  final int code;
  final String status;
  final String message;
  final Data data;

  ResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  String? username;
  String? otp;
  int otpExpiresSeconds;
  String? companyName;
  String? customerLogo;

  Data({
    this.username,
    this.otp,
    required this.otpExpiresSeconds,
    this.companyName,
    this.customerLogo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      username: json['username'],
      otp: json['otp'],
      otpExpiresSeconds: json['otp_expires_seconds'],
      companyName: json['company_name'],
      customerLogo: json['customer_logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'otp': otp,
      'otp_expires_seconds': otpExpiresSeconds,
      'company_name': companyName,
      'customer_logo': customerLogo,
    };
  }
}


// class ErrorResponse {
//   final int code;
//   final String message;
//   final Map<String, List<String>>? errors;

//   ErrorResponse({required this.code, required this.message, this.errors});

//   factory ErrorResponse.fromJson(Map<String, dynamic> json) {
//     return ErrorResponse(
//       code: json['code'] ?? 422,
//       message: json['message'] ?? 'An error occurred',
//       errors: json['errors'] != null 
//           ? Map<String, List<String>>.from(json['errors'].map((key, value) => 
//               MapEntry(key, List<String>.from(value))))
//           : null,
//     );
//   }
// }