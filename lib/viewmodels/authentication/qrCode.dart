import 'package:authenticator/utilities/imports/generalImport.dart';

class QrCodeViewModel extends BaseModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  bool _isProcessingScan = false;
  bool _hasCameraPermission = false;

  bool get hasCameraPermission => _hasCameraPermission;

  @override
  void dispose() {
    if (Platform.isIOS) {
      controller?.dispose();
      controller = null;
    } else {
      controller?.dispose();
    }
    super.dispose();
  }

  Future<void> requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      notifyListeners();
    } else {
      // Handle the case when the user denies the permission
    }
  }

//   Future<void> checkCameraPermission() async {
//     final status = await Permission.camera.status;
//     _hasCameraPermission = status.isGranted;
//     notifyListeners();
//   }

// Future<void> requestCameraPermission() async {
//   await checkCameraPermission(); // Check camera permission status

//   if (!_hasCameraPermission) {
//     final status = await Permission.camera.request();
//     _hasCameraPermission = status.isGranted;
//     notifyListeners();

//     if (!_hasCameraPermission) {
//       if (status.isPermanentlyDenied) {
//         // The user opted to never again see the permission request dialog.
//         // The only way to change the permission's status now is to let the
//         // user manually enable it in the system settings.
//         openAppSettings();
//       }
//     }
//   }
// }

  Widget buildQrView(BuildContext context) {
    // if (!_hasCameraPermission) {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         GeneralTextDisplay(
    //           'Camera permission is required to scan QR codes.',
    //           AppColors.black(),
    //           2,
    //           14,
    //           FontWeight.w400,
    //           "camera permission",
    //         ),
    //         const S(h: 20),
    //         buttonNoPositioned(
    //           context,
    //           navigator: requestCameraPermission,
    //           text: 'Grant Permission',
    //           fontSize: 12,
    //           radius: 8,
    //           buttonColor: AppColors.blueColor,
    //           width: sS(context).cW(width: 348),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppColors.blue(),
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: 300,
      ),
      formatsAllowed: const [BarcodeFormat.qrcode],
      cameraFacing: CameraFacing.back,
    );
  }

  Future<void> handleQRCode(String qrData) async {
    debugPrint("Raw QR code data: $qrData");

    try {
      Map<String, dynamic> loginData = jsonDecode(qrData);
      debugPrint("Parsed JSON data: $loginData");

      if (loginData.containsKey('username') &&
          loginData.containsKey('password')) {
        String username = loginData['username'];
        String password = loginData['password'];

        debugPrint("Username: $username, Password: $password");

        await qrCodeLogin(username, password);
      } else {
        throw Exception(
            "Invalid QR code format. Missing username or password.");
      }
    } catch (e) {
      debugPrint("Error processing QR code: $e");
      if (e is FormatException) {
        debugPrint("JSON parsing failed. Invalid JSON format.");
      }
      // Re-throw the exception to be caught by the caller
      rethrow;
    }
  }

  Future<void> qrCodeLogin(String username, String password) async {
    debugPrint("Attempting QR code login with username: $username");
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint("Context is null, cannot proceed with login");
      return;
    }

    runFunctionForApi(
      context,
      functionToRunAfterService: (value) async {
        if (value is ResponseModel) {
          debugPrint('USER LOGIN SUCCESSFULLY VIA QR CODE');
          responseModelBucket = value;
          companyBase64Image = responseModelBucket!.data.customerLogo;
          otpExpiresSeconds = responseModelBucket!.data.otpExpiresSeconds;
          companyName = responseModelBucket!.data.companyName;

          await saveLoginState();
          await saveQuickTools([
            QuickToolData(
              icon: companyBase64Image,
              title: companyName,
              subtitle: username,
              currentOtp: currentOtp,
              otpExpiresSeconds: otpExpiresSeconds!,
            )
          ]);
          debugPrint("Saved login state and QuickTool data successfully");
          debugPrint("Saved login state after QR code login successfully");
          // Attempt navigation
          debugPrint("Attempting navigation to home route");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              debugPrint("Context is mounted, proceeding with navigation");
              context.pushReplacementNamed(homeRoute);
            } else {
              debugPrint("Context is not mounted, navigation aborted");
            }
          });
          // // Use a more reliable navigation method
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   if (context.mounted) {
          //     //   Navigator.of(context)
          //     //       .pushNamedAndRemoveUntil(homeRoute, (route) => false);
          //     //   // context.pushNamed(homeRoute);
          //     try {
          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil(homeRoute, (route) => false);
          //     } catch (e) {
          //       debugPrint("Navigation error: $e");
          //       // Fallback navigation method
          //       Navigator.of(context).pushNamed(homeRoute);
          //     }
          //   }
          // });

          // Schedule the navigation after the current frame
          // Future.microtask(() {
          //   if (context.mounted) {
          // context.pushNamed(homeRoute);
          //   }
          // });
          notifyListeners();
        } else {
          debugPrint('LOGIN FAILED: ${value['message']}');
          loaderWithClose(context,
              text: formatErrorMessage(value['message']), removePage: false);
        }
      },
      functionToRunService: verifyLoginService(
        username: username,
        password: password,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    debugPrint("QR View created");
    this.controller = controller;
    notifyListeners();

    controller.scannedDataStream.listen((scanData) {
      debugPrint("Scanned data received: ${scanData.code}");
      if (!_isProcessingScan && scanData.code != null) {
        _isProcessingScan = true;
        result = scanData;
        notifyListeners();

        // Pause scanning
        controller.pauseCamera();

        handleQRCode(scanData.code!).then((_) {
          debugPrint("QR code processed successfully");
          _isProcessingScan = false;
        }).catchError((error) {
          debugPrint("Error processing QR code: $error");
          _isProcessingScan = false;
          // Resume scanning if there was an error
          controller.resumeCamera();
        });
      } else {
        debugPrint(
            "Scan skipped: _isProcessingScan=$_isProcessingScan, scanData.code=${scanData.code}");
      }
    }, onError: (error) {
      debugPrint("Error in scannedDataStream: $error");
    });

    debugPrint("QR View setup complete");
  }
}
