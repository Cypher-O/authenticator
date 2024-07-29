import 'package:authenticator/utilities/imports/generalImport.dart';

Widget addTokenQrCodeModal({
  required BuildContext context,
  required VoidCallback onCancel,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ViewModelBuilder<QrCodeViewModel>.reactive(
      viewModelBuilder: () => QrCodeViewModel(),
      onViewModelReady: (model) async {
        model.requestCameraPermission();
      },
      disposeViewModel: false,
      builder: (context, model, child) => Container(
        width: sS(context).cW(width: 350),
        padding: EdgeInsets.all(sS(context).cW(width: 16)),
        decoration: BoxDecoration(
          color: AppColors.white(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralTextDisplay(
              "Scan QR Code",
              AppColors.black(),
              1,
              16,
              FontWeight.w500,
              "Scan QR Code",
            ),
            const S(h: 10),
            Center(
              child: Container(
                width: 280,
                height: 280,
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
            const S(h: 18),
            buttonNoPositioned(
              context,
              text: "close",
              fontSize: 16,
              buttonColor: AppColors.gray3Light,
              navigator: onCancel,
              radius: 8,
              width: sS(context).cW(width: 348),
            ),
          ],
        ),
      ),
    ),
  );
}
