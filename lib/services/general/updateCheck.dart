import 'package:authenticator/utilities/imports/generalImport.dart';

Future<VersionInfoModel?> updateCheckService() async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  try {
    final response = await get(
      Uri.parse(latestApkUrl),
      headers: requestHeaders,
    );

    debugPrint('Response status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedResponse = json.decode(response.body);

      // Check if the response is in the expected format
      if (decodedResponse is Map<String, dynamic>) {
        return VersionInfoModel.fromJson(decodedResponse);
      } else {
        // Handle unexpected response format
        debugPrint('Unexpected response format');
        return decodedResponse;
        // return null;
      }
    } else {
      // Handle non-200 status code
      debugPrint('Failed to fetch version information');
      return null;
    }
  } catch (e) {
    // Handle any exceptions
    debugPrint('Error in updateCheckService: $e');
    return null;
  }
}


