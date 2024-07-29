import '../../../utilities/imports/generalImport.dart';

class ProviderLogo extends StatelessWidget {
  final double dimension;
  final String? image;
  final double borderRadius;
  final Color? color;
  const ProviderLogo(
      {super.key,
      this.dimension = 40.0,
      this.image,
      this.borderRadius = 8.0,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sS(context).cH(height: dimension),
      width: sS(context).cW(width: dimension),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(sS(context).cH(height: borderRadius)),
          color: color ?? AppColors.gray6()),
      child: Center(
        child: image == null
            ? SvgPicture.asset(
                'assets/no_image.svg',
                height: sS(context).cH(height: 24),
              )
            : image!.toLowerCase().endsWith('.svg')
                ? SvgPicture.network(
                    image!,
                    height: sS(context).cH(height: dimension),
                    placeholderBuilder: (BuildContext context) {
                      return SvgPicture.asset('assets/no_image.svg');
                    },
                  )
                : Image.network(
                    image!,
                    fit: BoxFit.contain,
                    height: sS(context).cH(height: dimension),
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return SvgPicture.asset('assets/no_image.svg');
                    },
                  ),
      ),
    );
  }
}
