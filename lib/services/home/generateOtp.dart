import 'package:authenticator/utilities/imports/generalImport.dart';

Future generateOtpService({required List<String> usernames}) async {
  try {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    Map<String, dynamic> data = {
      "usernames": usernames,
    };

    debugPrint('Request Headers: $requestHeaders');
    debugPrint('Request Data: $data');

    final response = await post(
      Uri.parse(generateOtpUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint("RESPONSE: ${response.statusCode}");
    debugPrint("RESPONSE BODY: ${response.body}");

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenerateOtpResponse.fromJson(decodedResponse);
      } else {
        return decodedResponse;
        // throw Exception(
        //     'Failed to generate otp. Status Code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error processing generate otp response: $e');
    }
  } catch (e) {
    debugPrint('Error in GeneratingOtpService: $e');
    throw Exception('An error occurred: $e');
  }
}
