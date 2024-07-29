// base url
const String baseUrl = "https://authenticator-api-v1ck.onrender.com/api/auth/";

// authenticator APK update
const String latestApkUrl =
    "https://authenticatorv1.s3.us-east-2.amazonaws.com/updates/versionCheck.json";

// authentication urls
const String signInUrl = "${baseUrl}verify-user";

//generate otp
const String generateOtpUrl = "${baseUrl}generate-otp";
