// creating a function to prevent calling catch error and try catch in multiple places

import 'package:authenticator/utilities/imports/generalImport.dart';

BaseModel baseModel = BaseModel();

// Future<bool> runFunctionForApi(
//   BuildContext context, {
//   required Future functionToRunService,
//   bool noLoading = false,
//   required Function(dynamic) functionToRunAfterService,
// }) async {
//   try {
//     // loading
//     if (!noLoading) {
//       loadingDialog(context, text: "");
//     }

//     // Adding a timeout of 1 minute
//     final timeoutDuration = Duration(seconds: 60);

//     // Run the function with timeout
//     final result = await Future.any([
//       functionToRunService,
//       Future.delayed(timeoutDuration, () => 'timeout')
//     ]);

//     // Check if timeout was exceeded
//     if (result == 'timeout') {
//       if (!noLoading) Navigator.pop(context);
//       loaderWithClose(context, text: "Network busy. Retry", removePage: false);
//       return false;
//     } else {
//       if (!noLoading) Navigator.pop(context);
//       handleApiResponse(context, result, functionToRunAfterService);
//       return true;
//     }
//   } catch (onError, stacktrace) {
//     debugPrint('stacktrace is ${stacktrace.toString()}');
//     handleApiError(context, onError, noLoading);
//     return false;
//   }
// }

// void handleApiResponse(
//   BuildContext context,
//   dynamic result,
//   Function(dynamic) functionToRunAfterService,
// ) {
//   if (result is Map<String, dynamic> && result['log_out'] == true) {
//     loaderWithClose(
//       context,
//       text: baseModel.formatErrorMessage(result['message']),
//       removePage: false,
//       onTap: () {
//         // if (result['log_out'] == true) {
//         baseModel.logoutFunction();
//         // }
//       },
//     );
//   } else {
//     functionToRunAfterService(result);
//   }
// }

// void handleApiError(BuildContext context, dynamic error, bool noLoading) {
//   if (!noLoading) Navigator.pop(context);
//   if (error is SocketException) {
//     loaderWithClose(context, text: networkError);
//   } else if (error is FormatException) {
//     loaderWithClose(context, text: undefinedError);
//   } else {
//     showLogoutModal(context);
//   }
// }

// void showLogoutModal(BuildContext context) {
//   final model = BaseModel();
//   loaderWithInfo(context,
//       text: 'Kindly Login in Again',
//       title: "Session Expired",
//       // title: "Unauthenticated",
//       iconColor: AppColors.red(),
//       onTap: () {
//         model.logoutFunction(navigateTo: loginRoute);
//       },
//       cancelText: 'Cancel',
//       acceptText: 'Login',
//       cancelTap: () {
//         model.logoutFunction();
//       });
// }



Future<bool> runFunctionForApi(
  BuildContext context, {
  required Future functionToRunService,
  bool noLoading = false,
  required Function(dynamic) functionToRunAfterService,
}) async {
  try {
    // Show loading dialog if required
    if (!noLoading) {
      loadingDialog(context, text: "");
    }

    // Set timeout duration
    // const timeoutDuration = Duration(seconds: 60);
    const timeoutDuration = Duration(seconds: 40);
    debugPrint("Running function with timeout of $timeoutDuration");

    // Run the service function with a timeout
    final result = await Future.any([
      functionToRunService,
      Future.delayed(timeoutDuration, () => 'timeout')
    ]);

    // Handle timeout
    if (result == 'timeout') {
      debugPrint("API call timed out");
      if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
      if (!noLoading) Navigator.pop(context);
      loaderWithClose(context, text: "Network busy. Retry", removePage: false);
      return false;
    } else {
      // Service call completed successfully
      debugPrint("API call completed within timeout with result: $result");
      try {
        //comment this out to check the error and uncomment later
        if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
        if (!noLoading) Navigator.pop(context);
        debugPrint("Executing functionToRunAfterService...");
        await functionToRunAfterService(result);
        debugPrint("Executed functionToRunAfterService successfully");
        return true;
      } catch (onError) {
        debugPrint("Error in functionToRunAfterService: $onError");
        if (onError is SocketException && !noLoading) {
          loaderWithClose(context, text: networkError, removePage: false);
          if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
          if (!noLoading) Navigator.pop(context);
        } else if (onError is FormatException && !noLoading) {
          if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
          Navigator.pop(context);
          debugPrint('FormatException error: $onError');
        } else {
          if (!noLoading) {
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.pop(context);
            debugPrint('Unknown error: $onError');
            loaderWithClose(context, text: undefinedError, removePage: false);
          }
        }
        return false;
      }
    }
  } catch (onError, stacktrace) {
    debugPrint('Exception in runFunctionForApi: $onError');
    debugPrint('StackTrace: $stacktrace');
    if (onError is SocketException && !noLoading) {
      if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
      if (!noLoading) Navigator.pop(context);
      loaderWithClose(context, text: networkError, removePage: false);
    } else if (onError is FormatException && !noLoading) {
      if (!noLoading) await Future.delayed(const Duration(milliseconds: 100));
      Navigator.pop(context);
    } else {
      if (!noLoading) {
        await Future.delayed(const Duration(milliseconds: 100));
        Navigator.pop(context);
        loaderWithClose(context, text: undefinedError, removePage: false);
      }
    }
    return false;
  }
}


// Future<bool> runFunctionForApi(
//   BuildContext context, {
//   required Future functionToRunService,
//   bool noLoading = false,
//   required Function(dynamic) functionToRunAfterService,
// }) async {
//   try {
//     // Show loading dialog if required
//     if (!noLoading) {
//       loadingDialog(context, text: "");
//     }

//     // Set timeout duration
//     const timeoutDuration = Duration(seconds: 60);
//     debugPrint("Running function with timeout of $timeoutDuration");

//     // Run the service function with a timeout
//     final result = await Future.any([
//       functionToRunService,
//       Future.delayed(timeoutDuration, () => 'timeout')
//     ]);

//     // Handle timeout
//     if (result == 'timeout') {
//       debugPrint("API call timed out");
//       if (!noLoading) Navigator.pop(context);
//       loaderWithClose(context, text: "Network busy. Retry", removePage: false);
//       return false;
//     } else {
//       // Service call completed successfully
//       debugPrint("API call completed within timeout with result: $result");
//       try {
//         //comment this out to check the error and uncomment later
//         if (!noLoading) Navigator.pop(context);
//         debugPrint("Executing functionToRunAfterService...");
//         await functionToRunAfterService(result);
//         debugPrint("Executed functionToRunAfterService successfully");
//         return true;
//       } catch (onError) {
//         debugPrint("Error in functionToRunAfterService: $onError");
//         if (onError is SocketException && !noLoading) {
//           loaderWithClose(context, text: networkError);
//           if (!noLoading) Navigator.pop(context);
//         } else if (onError is FormatException && !noLoading) {
//           Navigator.pop(context);
//           debugPrint('FormatException error: $onError');
//         } else {
//           if (!noLoading) {
//             Navigator.pop(context);
//             debugPrint('Unknown error: $onError');
//             loaderWithClose(context, text: undefinedError);
//           }
//         }
//         return false;
//       }
//     }
//   } catch (onError, stacktrace) {
//     debugPrint('Exception in runFunctionForApi: $onError');
//     debugPrint('StackTrace: $stacktrace');
//     if (onError is SocketException && !noLoading) {
//       if (!noLoading) Navigator.pop(context);
//       loaderWithClose(context, text: networkError);
//     } else if (onError is FormatException && !noLoading) {
//       Navigator.pop(context);
//     } else {
//       if (!noLoading) {
//         Navigator.pop(context);
//         loaderWithClose(context, text: undefinedError);
//       }
//     }
//     return false;
//   }
// }
