import 'dart:developer';

import 'package:authenticator/utilities/imports/generalImport.dart';

class HomeViewModel extends BaseModel {
  final mainScrollController = ScrollController();
  //controller
  final searchController = TextEditingController();

  bool isLoggedIn = false;

  bool searchError = false;
  // focus node
  FocusNode searchFocusNode = FocusNode();
  List<QuickToolData> quickTools = [];
  List<QuickToolData> displayedQuickTools = [];

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  bool _isSearchFocused = false;
  bool get isSearchFocused => _isSearchFocused;

  bool get hasSearchResults => displayedQuickTools.isNotEmpty;
  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  void setCredentials(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool loggedIn = false;

  bool get obscureText => _obscureText;

  void obscureTextFunction() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool userNameError = false;
  bool passwordError = false;

  // focus node
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  onChangedFunctionUserName() {
    userNameFocusNode.addListener(() {
      if (userNameFocusNode.hasFocus == false) {
        userNameError = false;
        notifyListeners();
      }
    });

    if (isValidUserName(usernameController.text.trim())) {
      userNameError = false;
      // String username = usernameController.text.trim();
      notifyListeners();
    } else {
      userNameError = true;
      notifyListeners();
    }
  }

  // on change password function
  onChangedFunctionPassword() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus == false) {
        passwordError = false;
        notifyListeners();
      }
    });
    if (isValidPassword(passwordController.text.trim())) {
      passwordError = false;
      notifyListeners();
    } else {
      passwordError = true;
      notifyListeners();
    }
  }

  Future<bool> _validateForm() async {
    if (!isValidUserName(usernameController.text.trim())) {
      userNameError = true;
      notifyListeners();
      userNameFocusNode.requestFocus();
      return false;
    } else if (!isValidPassword(passwordController.text.trim())) {
      passwordError = true;
      notifyListeners();
      passwordFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final quickToolsJson = prefs.getString('quickTools');

    if (quickToolsJson != null && quickToolsJson.isNotEmpty) {
      final List<dynamic> quickToolsList = json.decode(quickToolsJson);
      for (var item in quickToolsList) {
        final quickTool = QuickToolData.fromJson(item);
        if (quickTool.subtitle == username) {
          return true;
        }
      }
    }
    return false;
  }

  void showAddTokenUsernamePassword(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0
              // bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
          child: addTokenUsernamePasswordModal(
            context: context,
            onLogin: (username, password) {
              setCredentials(username, password);
              Navigator.pop(context);
              notifyListeners();
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void showAddTokenQrCode(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: addTokenQrCodeModal(
            context: context,
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void initSearchFocusListener() {
    searchFocusNode.addListener(_onSearchFocusChange);
  }

  void disposeSearchFocusListener() {
    searchFocusNode.removeListener(_onSearchFocusChange);
  }

  void _onSearchFocusChange() {
    _isSearchFocused = searchFocusNode.hasFocus;
    notifyListeners();
  }

  void clearSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      searchQuickTools();
    } else {
      searchFocusNode.unfocus();
    }
    notifyListeners();
  }

  // void onSearchChanged() {
  //   searchQuickTools();
  //   notifyListeners();
  // }

  bool _isFabExpanded = false;
  late AnimationController _animationController;

  bool get isFabExpanded => _isFabExpanded;
  AnimationController get animationController => _animationController;

  void initAnimationController(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
  }

  void toggleFab() {
    _isFabExpanded = !_isFabExpanded;
    if (_isFabExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleSearch() {
    if (_isSearching) {
      searchController.clear();
      searchQuickTools();
      searchFocusNode.unfocus();
    } else {
      searchFocusNode.requestFocus();
    }
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void onSearchChanged() {
    searchQuickTools();
    _isSearching = searchController.text.isNotEmpty;
    notifyListeners();
  }

  void generateOtp(BuildContext context, int index,
      {bool noLoading = true}) async {
    if (isLoggedIn && index < quickTools.length) {
      String username = quickTools[index].username ?? '';
      if (username.isEmpty) {
        // Fetch username from subtitle if it's empty
        username = quickTools[index].subtitle ?? '';
      }
      runFunctionForApi(
        context,
        noLoading: noLoading,
        functionToRunAfterService: (value) async {
          if (value is GenerateOtpResponse) {
            if (value.code == 0) {
              debugPrint('OTP GENERATED SUCCESSFULLY');
              generateOtpResponseBucket = value;
              quickTools[index].otpExpiresSeconds =
                  value.data.first.otpExpiresSeconds;
              quickTools[index].currentOtp = value.data.first.otp;

              debugPrint(
                  'OTP Expires Seconds: ${quickTools[index].otpExpiresSeconds}');
              debugPrint('Current OTP: ${quickTools[index].currentOtp}');
              notifyListeners();
            } else {
              loaderWithClose(context,
                  text: formatErrorMessage(value.message), removePage: false);
            }
          } else {
            loaderWithClose(context,
                text: formatErrorMessage(value['message']), removePage: false);
          }
        },
        functionToRunService: generateOtpService(
          usernames: [username],
        ),
      );
    }
  }

  addTokenUsernamePassword(BuildContext context) async {
    clearFocus(context);
    bool validated = await _validateForm();
    if (validated) {
      String username = usernameController.text.trim();
      bool usernameExists = await doesUsernameExist(username);

      if (usernameExists) {
        loaderWithClose(context,
            text: 'The token is already on the list!', removePage: false);
        return;
      }

      runFunctionForApi(
        context,
        functionToRunAfterService: (value) async {
          if (value is ResponseModel) {
            if (value.code == 0) {
              debugPrint(
                  'NEW TOKEN VIA USERNAME & PASSWORD ADDED SUCCESSFULLY');
              responseModelBucket = value;
              companyBase64Image = responseModelBucket!.data.customerLogo;
              otpExpiresSeconds = responseModelBucket!.data.otpExpiresSeconds;
              companyName = responseModelBucket!.data.companyName;
              _username = responseModelBucket!.data.username!;
              currentOtp = responseModelBucket!.data.otp ?? "";

              await saveLoginState();
              // Create a new QuickToolData object
              QuickToolData newQuickTool = QuickToolData(
                icon: companyBase64Image,
                title: companyName,
                subtitle: _username,
                currentOtp: currentOtp,
                otpExpiresSeconds: otpExpiresSeconds!,
              );

              // Add the new QuickToolData to the quickTools list
              quickTools.add(newQuickTool);

              // Update the displayed quick tools
              displayedQuickTools = List.from(quickTools);
              await saveQuickTools([newQuickTool]);
              debugPrint("Saved login state and QuickTool data successfully");
              debugPrint("Saved login state after login successfully");
              Navigator.pop(context);
              context.pushNamed(homeRoute);
              notifyListeners();
              // Generate OTP for the new token
              generateOtp(context, quickTools.length - 1);
            } else {
              loaderWithClose(context,
                  text: formatErrorMessage(value.message), removePage: false);
              debugPrint("Message ${value.message}");
            }
          } else {
            loaderWithClose(context,
                text: formatErrorMessage(value['message']), removePage: false);
            debugPrint("Message ${value['message']}");
          }
        },
        functionToRunService: verifyLoginService(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  void updateOtp(String newOtp, int index) {
    if (index < quickTools.length) {
      quickTools[index].currentOtp = newOtp;
      notifyListeners();
    }
  }

  Future<DecodeUsernameModel> fetchQuickToolDataService() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final quickToolsJson = prefs.getString('quickTools');

      if (quickToolsJson == null || quickToolsJson.isEmpty) {
        // Handle case where no data is in SharedPreferences
        // Fetch data from API or set default state
        return DecodeUsernameModel(code: 1, message: "No data available");
      } else {
        // Data exists in SharedPreferences, parse and return
        final List<dynamic> quickToolsList = json.decode(quickToolsJson);
        final quickTools =
            quickToolsList.map((item) => QuickToolData.fromJson(item)).toList();

        // Log the number of items loaded
        debugPrint('Loaded ${quickTools.length} items from SharedPreferences');

        return DecodeUsernameModel(
          code: 0,
          message: "Success",
          data: quickTools,
        );
      }
    } catch (e) {
      // Handle error case
      return DecodeUsernameModel(
        code: 1,
        message: "An error occurred: ${e.toString()}",
        data: null,
      );
    }
  }

  Future<DecodeUsernameModel> fetchQuickToolsFromAPI() async {
    try {
      final loginViewModel = LoginViewModel();
      final response = await verifyLoginService(
        username: loginViewModel.usernameController.text,
        password: loginViewModel.passwordController.text,
      );

      if (response is ResponseModel && response.code == 0) {
        final quickToolData = QuickToolData(
          icon: response.data.customerLogo,
          title: response.data.companyName,
          subtitle: response.data.username,
          username: response.data.username,
          currentOtp: response.data.otp ?? '',
          otpExpiresSeconds: response.data.otpExpiresSeconds,
        );

        return DecodeUsernameModel(
          code: 0,
          message: "Success",
          data: [quickToolData],
        );
      } else {
        throw Exception('Failed to fetch quick tool data from API');
      }
    } catch (e) {
      return DecodeUsernameModel(
        code: 1,
        message: "An error occurred while fetching from API: ${e.toString()}",
        data: null,
      );
    }
  }

  Future<void> fetchQuickToolData(BuildContext context) async {
    isLoggedIn = await checkLoginState(context);

    if (isLoggedIn) {
      final result = await fetchQuickToolDataService();
      if (result.code == 0 && result.data != null) {
        quickTools = result.data!;
        displayedQuickTools = List.from(quickTools);
        // Print the fetched items
        // quickTools.forEach((tool) {
        //   log('QuickToolData: ${tool.toJson()}');
        // });

        // Log each QuickToolData item from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final quickToolsJson = prefs.getString('quickTools');

        if (quickToolsJson != null) {
          final List<dynamic> savedQuickTools =
              json.decode(quickToolsJson) as List<dynamic>;

          for (var item in savedQuickTools) {
            final quickTool = QuickToolData.fromJson(item);
            log('QuickToolData from SharedPreferences: ${quickTool.toJson()}');
          }
        }
        notifyListeners();
      } else {
        debugPrint('Error fetching quick tool data: ${result.message}');
      }
    } else {
      quickTools.clear();
    }

    notifyListeners();
  }

  void searchQuickTools() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      displayedQuickTools =
          List.from(quickTools); // Show all items if query is empty
    } else {
      displayedQuickTools = quickTools
          .where((tool) =>
              (tool.title?.toLowerCase().contains(query) ?? false) ||
              (tool.subtitle?.toLowerCase().contains(query) ?? false))
          .toList();
    }
    notifyListeners();
  }
}
