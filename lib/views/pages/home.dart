import 'package:authenticator/utilities/imports/generalImport.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) async {
        model.initAnimationController(this);
        model.initSearchFocusListener();
        await model.fetchQuickToolData(context);
        if (model.isLoggedIn) {
          for (int i = 0; i < model.quickTools.length; i++) {
            model.generateOtp(context, i);
          }
        }
      },
      disposeViewModel: false,
      onDispose: (model) => model.disposeSearchFocusListener(),
      builder: (context, model, child) => PopScope(
        canPop: false,
        child: BaseUi(
          refreshedEnabled: true,
          safeTop: true,
          onRefreshFunction: () async {
            model.initAnimationController(this);
            model.initSearchFocusListener();
            await model.fetchQuickToolData(context);
            if (model.isLoggedIn) {
              for (int i = 0; i < model.quickTools.length; i++) {
                model.generateOtp(context, i);
              }
            }
          },
          children: [
            rowPositioned(
              top: 40,
              left: 16,
              right: 16,
              child: FormattedTextFields(
                keyInputType: TextInputType.name,
                textFieldController: model.searchController,
                textFieldHint: "Search service or account",
                noBorder: false,
                inputFormatters: const [],
                onChangedFunction: () => model.searchQuickTools(),
                errorTextActive: model.searchError,
                focusNode: model.searchFocusNode,
                suffixIcon: GestureDetector(
                  onTap: () => model.clearSearch(),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return RotationTransition(
                        turns: animation,
                        child: child,
                      );
                    },
                    child: model.isSearchFocused
                        ? Icon(
                            Icons.close,
                            key: ValueKey<bool>(model.isSearchFocused),
                            color: AppColors.black(),
                            size: 18,
                          )
                        : Icon(
                            Icons.menu,
                            key: ValueKey<bool>(model.isSearchFocused),
                            color: AppColors.black(),
                            size: 18,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: sS(context).cH(height: 100),
              left: 16,
              right: 16,
              bottom: sS(context).cH(height: 0),
              child: model.hasSearchResults
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const S(h: 30),
                          ...List.generate(
                            model.displayedQuickTools.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: quickToolWidget(
                                otpExpiresSeconds: model
                                    .displayedQuickTools[index]
                                    .otpExpiresSeconds,
                                context: context,
                                icon:
                                    model.displayedQuickTools[index].icon ?? "",
                                title: model.displayedQuickTools[index].title ??
                                    "",
                                subtitle:
                                    model.displayedQuickTools[index].subtitle ??
                                        "",
                                additionalText:
                                    model.displayedQuickTools[index].currentOtp,
                                copiedOtp:
                                    model.displayedQuickTools[index].currentOtp,
                                titleColor: AppColors.black(),
                                backgroundColor: AppColors.greyedOutColor(),
                                callback: () {},
                                generateOtp: () =>
                                    model.generateOtp(context, index),
                                updateOtp: (String newOtp) =>
                                    model.updateOtp(newOtp, index),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        "No matching results found",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grey(),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: sS(context).cH(height: 100),
                  right: sS(context).cW(width: 16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Option 2
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: model.isFabExpanded ? 40.0 : 0.0,
                      width: model.isFabExpanded ? 40.0 : 0.0,
                      child: FloatingActionButton(
                        heroTag: 'fab2',
                        backgroundColor: AppColors.blueColor,
                        mini: true,
                        child: Icon(Icons.add, color: AppColors.white()),
                        onPressed: () {
                          model.showAddTokenUsernamePassword(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Option 1
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: model.isFabExpanded ? 40.0 : 0.0,
                      width: model.isFabExpanded ? 40.0 : 0.0,
                      child: FloatingActionButton(
                        heroTag: 'fab1',
                        backgroundColor: AppColors.blueColor,
                        mini: true,
                        child: Icon(Icons.qr_code_scanner_rounded,
                            color: AppColors.white()),
                        onPressed: () {
                          model.showAddTokenQrCode(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Main FAB
                    FloatingActionButton(
                      heroTag: 'mainFab',
                      backgroundColor: AppColors.blueColor,
                      child: AnimatedIcon(
                        color: AppColors.white(),
                        icon: AnimatedIcons.menu_close,
                        progress: model.animationController,
                      ),
                      onPressed: () {
                        model.toggleFab();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
