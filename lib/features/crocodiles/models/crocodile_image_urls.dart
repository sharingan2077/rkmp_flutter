class CrocodileImageUrls {
  static const String dashboardHeader = 'https://example.com/dashboard-header.jpg';
  static const String defaultCrocodile = 'https://example.com/default-crocodile.jpg';

  // You can add more image URLs here or fetch from API
  static String getCrocodileImage(String crocodileId) {
    // Your logic to get specific crocodile image
    return 'https://example.com/crocodile-$crocodileId.jpg';
  }
}