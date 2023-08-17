bool isValidPhotoUrl(String url) {
  // Регулярное выражение для проверки URL изображения.
  RegExp regExp = RegExp(
    r'^https?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp|webp)',
    caseSensitive: false,
    multiLine: false,
  );

  return regExp.hasMatch(url);
}
