import 'package:authenticator/utilities/imports/generalImport.dart';

class UpdateCheckViewModel extends BaseModel {
  ValueNotifier<double> _downloadProgress = ValueNotifier<double>(0.0);
  late BuildContext _alertContext;
  Completer<void>? _cancelCompleter;

  UpdateCheckViewModel() {
    _downloadProgress = ValueNotifier<double>(0.0);
  }

  @override
  void dispose() {
    _downloadProgress.dispose();
    super.dispose();
  }

  Future<void> checkForUpdate(BuildContext context) async {
    setBusy(true);
    debugPrint("Checking for update...");
    VersionInfoModel? versionInfo = await performUpdateCheck(context);
    setBusy(false);

    if (versionInfo != null) {
      debugPrint("Update is available, showing update dialog...");
      _showUpdateDialog(context, versionInfo.severity);
    }
  }

  performUpdateCheck(BuildContext context, {bool noLoading = true}) async {
    runFunctionForApi(context, noLoading: noLoading,
        functionToRunAfterService: (value) async {
      try {
        notifyListeners();
        if (value is VersionInfoModel) {
          latestVersion = value.version;
          downloadUrl = value.downloadUrl;
          String installedVersion = appVersion;

          if (await isNewVersionAvailable(installedVersion, latestVersion!)) {
            debugPrint("New version is available");
            _showUpdateDialog(context, value.severity);
          }
        }
        notifyListeners();
      } catch (e, stackTrace) {
        debugPrint('Exception in performUpdateCheck: $e\n$stackTrace');
      }
    }, functionToRunService: updateCheckService());
  }

  Future<bool> isNewVersionAvailable(
      String installedVersion, String latestVersion) async {
    try {
      bool isNew = latestVersion.compareTo(installedVersion) > 0;
      debugPrint(
          "Installed version: $installedVersion, Latest version: $latestVersion, isNew: $isNew");
      return isNew;
    } catch (e) {
      debugPrint("Could not get package version: $e");
      return false;
    }
  }

  Future<void> _showUpdateDialog(BuildContext context, int severity) async {
    _alertContext = context;
    debugPrint("Showing update dialog...");
    if (severity == 0) {
      loaderWithCompulsoryDownload(
        context,
        text: "A mandatory update is available. Please update now.",
        title: "Update Available",
        icon: Icons.system_update,
        onTap: () {
          Navigator.pop(context);
          _showDownloadProgressDialog(context, _downloadProgress);
        },
        acceptText: "Update",
        acceptColor: AppColors.blue(),
        iconColor: AppColors.blue(),
        removePage: false,
      );
    } else if (severity == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedVersion = prefs.getString('latest_version');
      debugPrint("The Latest version in shared Prefrence: $savedVersion");

      if (savedVersion != latestVersion) {
        // If the saved version is different from the latest version,
        // show the dialog and save the latest version to SharedPreferences
        loaderWithInfo(
          context,
          text: "A new version of the app is available. Do you want to update?",
          title: "Update Available",
          icon: Icons.system_update,
          onTap: () {
            Navigator.pop(context);
            _showDownloadProgressDialog(context, _downloadProgress);
          },
          cancelTap: () async {
            // Save the latest version to SharedPreferences
            await prefs.setString('latest_version', latestVersion!);
            debugPrint(
                "Latest version is currently being saved into shared preference: $latestVersion");
            Navigator.pop(context);
          },
          cancelText: "Not Now",
          acceptText: "Update",
          acceptColor: AppColors.blue(),
          iconColor: AppColors.blue(),
          removePage: false,
        );
      } else {
        // If the saved version is the same as the latest version, don't show the dialog
        debugPrint("Same version, not showing update dialog for severity 1");
      }
    }
  }

  Future<void> _showDownloadProgressDialog(
      BuildContext context, ValueNotifier<double> progressNotifier) async {
    _cancelCompleter = Completer<void>();
    showAlertDialog(
      context,
      progressNotifier: progressNotifier,
    );
    // Start the download after showing the dialog
    _launchURL(downloadUrl!, progressNotifier);
  }

  Future<void> _launchURL(
      String url, ValueNotifier<double> progressNotifier) async {
    debugPrint("Starting download from URL: $url");

    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        debugPrint("Directory path is null");
        return;
      }

      final filePath = '${directory.path}/authenticatorUpdate.apk';
      final client = Client();
      final request = Request('GET', Uri.parse(url));

      // Check if the file already exists and delete it to avoid appending
      if (await File(filePath).exists()) {
        await File(filePath).delete();
      }

      final response = await client.send(request);
      final File file = File(filePath);
      final IOSink sink = file.openWrite();

      int totalBytes = response.contentLength ?? 0;
      int receivedBytes = 0;

      _cancelCompleter?.future.then((_) {
        // response.stream.cancel();
        sink.close();
        client.close();
      });

      response.stream.listen(
        (List<int> chunk) {
          if (_cancelCompleter?.isCompleted ?? false) {
            // response.stream.cancel();
            sink.close();
            client.close();
            return;
          }

          receivedBytes += chunk.length;
          double progress = receivedBytes / totalBytes;
          debugPrint("Download progress: $progress");
          progressNotifier.value = progress;

          sink.add(chunk);
        },
        onDone: () async {
          await sink.flush();
          await sink.close();
          await installApk(filePath);
          debugPrint("Download completed, APK installed");
          Navigator.of(_alertContext)
              .pop(); // Close the download progress dialog
          client.close();
        },
        onError: (error) {
          debugPrint("Download error: $error");
          sink.close();
          client.close();
          Navigator.of(_alertContext)
              .pop(); // Close the download progress dialog
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  Future<void> installApk(String filePath) async {
    try {
      debugPrint("Installing new APK from file: $filePath");

      // Install new APK
      final FlutterAppInstaller flutterAppInstaller = FlutterAppInstaller();
      bool installSuccess = await flutterAppInstaller.installApk(
        filePath: filePath,
      );

      if (installSuccess) {
        debugPrint("APK installation successful");
      } else {
        debugPrint("Failed to install APK");
        throw Exception("Failed to install APK");
      }
    } catch (e) {
      debugPrint("Error during APK installation: $e");
      throw Exception("Failed to install APK");
    }
  }
}
