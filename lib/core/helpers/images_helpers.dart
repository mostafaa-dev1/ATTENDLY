class ImagesHelpers {
  static const String logo = 'assets/images/logo.png';
  static const String logoDark = 'assets/images/logo_dark.png';
  static const String splash = 'assets/images/splash.png';
  static const String splashDark = 'assets/images/splash_dark.png';
  static String genderImage(String? gender) =>
      'assets/images/${gender == 'Male' || gender == 'male' ? 'boy' : 'woman'}.png';
}
