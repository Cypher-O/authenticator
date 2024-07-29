import 'package:authenticator/utilities/imports/generalImport.dart';

class HybridWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function? callback;
  final String? navigateTo;
  const HybridWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      this.navigateTo,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      viewModelBuilder: () => BaseModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: sS(context).cW(width: 16)),
                color: AppColors.white(),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_rounded,
                        color: AppColors.orange(), size: 72),
                    const S(h: 24),
                    GeneralTextDisplay(
                      title,
                      AppColors.black(),
                      2,
                      20,
                      FontWeight.w500,
                      '',
                      textAlign: TextAlign.center,
                    ),
                    const S(h: 12),
                    GeneralTextDisplay(
                      subtitle,
                      AppColors.gray3(),
                      5,
                      14,
                      FontWeight.w400,
                      '',
                      textAlign: TextAlign.center,
                    ),
                    const S(h: 30),
                    buttonNoPositioned(context,
                        text: buttonText,
                        navigateTo: navigateTo,
                        navigator: callback == null
                            ? null
                            : () {
                                callback!();
                              }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
