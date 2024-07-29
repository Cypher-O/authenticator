import 'package:authenticator/utilities/imports/generalImport.dart';

Future verifyLoginService(
    {required String username, required String password}) async {
  try {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    Map<String, dynamic> data = {
      "username": username,
      "password": password,
    };

    debugPrint('Request Headers: $requestHeaders');
    debugPrint('Request Data: $data');

    final response = await post(
      Uri.parse(signInUrl),
      headers: requestHeaders,
      body: json.encode(data),
    );

    debugPrint("RESPONSE: ${response.statusCode}");
    debugPrint("RESPONSE BODY: ${response.body}");

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseModel.fromJson(decodedResponse);
      } else {
        return decodedResponse;
        // throw Exception(
        //     'Failed to Verify User. Status Code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error processing User response: $e');
    }
  } catch (e) {
    debugPrint('Error in VerifyingUserService: $e');
    throw Exception('An error occurred: $e');
  }
}
