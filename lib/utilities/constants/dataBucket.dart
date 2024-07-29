import 'package:authenticator/utilities/imports/generalImport.dart';
// list of stored data bucket

// general bucket
bool isBusyState = false;

//authentication bucket

bool isDarkModeBucket = false;

// Check if the platform is iOS
bool isIOS = Platform.isIOS;

String? otpToken;

String? downloadUrl;

ResponseModel? responseModelBucket;

GenerateOtpResponse? generateOtpResponseBucket;

String? companyBase64Image;
String? username;
String? companyName;

int? otpExpiresSeconds;

String currentOtp = "";
