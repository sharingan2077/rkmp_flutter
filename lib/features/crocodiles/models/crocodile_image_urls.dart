class CrocodileImageUrls {
  static const String dashboardHeader = 'https://example.com/dashboard-header.jpg';
  static const String defaultCrocodile = 'https://example.com/default-crocodile.jpg';

  static String getCrocodileImage(String crocodileId) {
    return 'https://example.com/crocodile-$crocodileId.jpg';
  }
  static String getCrocodileListImage() {
    return 'https://masterpiecer-images.s3.yandex.net/eb0fb74e89be11eeb35f1ad242dc1d78:upscaled';
  }

  static String getCrocodileFormImage() {
    return 'https://i.pinimg.com/736x/89/55/99/8955992889f0215396a783fbf627c574.jpg';
  }
}