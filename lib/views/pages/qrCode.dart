import 'package:authenticator/utilities/imports/generalImport.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrCodeViewModel>.reactive(
      viewModelBuilder: () => QrCodeViewModel(),
      onViewModelReady: (model) async {
        model.requestCameraPermission();
      },
      disposeViewModel: false,
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: BaseUi(
          refreshedEnabled: true,
          safeTop: true,
          onRefreshFunction: () {},
          children: [
            backButton(context, pageName: "Scan QR Code"),
            Positioned(
              top: sS(context).cH(height: 150),
              left: sS(context).cW(width: 16),
              bottom: sS(context).cH(height: 70),
              right: sS(context).cW(width: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.greyedOutColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Container(
                    height: 270,
                    width: 270,
                    decoration: BoxDecoration(
                      color: AppColors.white(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: model.buildQrView(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
