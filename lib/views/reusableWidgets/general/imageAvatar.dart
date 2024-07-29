import 'package:authenticator/utilities/imports/generalImport.dart';

class ImageAvatar extends StatelessWidget {
  final String? image;
  final ImageTypeEnum? imageType;
  final double? width;
  const ImageAvatar({super.key, this.image, this.imageType, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (image == null || image == '' || image == 'null')
            ? SvgPicture.asset('assets/avatar/avatar.svg',
                height: sS(context).cH(height: 40))
            : CircleAvatar(
                radius: sS(context).cH(height: 20),
                backgroundColor: AppColors.gray3(),
                backgroundImage: NetworkImage(image!),
                onBackgroundImageError: (Object error, StackTrace? stackTrace) {
                  return;
                },
              ));
    // Container(
    //   key: UniqueKey(),
    //   width: sS(context).cW(width: width ?? 32),
    //   height: sS(context).cH(height: width ?? 32),
    //   decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       border:
    //           image == null ? Border.all(color: AppColors.gray5()) : Border.all(width: 0)),
    //   alignment: Alignment.center,
    //   child: image == null
    //       ? GeneralIconDisplay(Icons.person, AppColors.gray3(), UniqueKey(), 30)
    //       : imageType == ImageTypeEnum.png
    //           ? Image.network(
    //               image!,
    //               //  height: sS(context).cH(height: 24),
    //               errorBuilder: (BuildContext context, Object error,
    //                   StackTrace? stackTrace) {
    //                 return SvgPicture.asset('assets/avatar/avatar.svg');
    //               },
    //               fit: BoxFit.cover,
    //             )
    //           : WebsafeSvg.asset(image!),
    // );
  }
}
