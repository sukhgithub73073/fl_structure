part of 'helpers.dart';


Widget loginAndSignCommonScreen(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          AssetsPath.splashScreenCut,
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            image: DecorationImage(
              image: AssetImage(AssetsPath.rectangle31),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: screenHeight(context) * 0.12,
                width: screenWidth(context) * 0.60,
                child: Image.asset(
                  AssetsPath.appLogo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
