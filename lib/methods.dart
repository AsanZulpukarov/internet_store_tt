String formatNumberWithSpaces(int number) {
  String numberString = number.toString();
  RegExp regExp = RegExp(r'\d{1,3}(?=(\d{3})+(?!\d))');
  // Замена каждых трех символов с пробелами
  String formattedNumber = numberString.replaceAllMapped(
      regExp, (Match match) => '${match.group(0)} ');
  return formattedNumber;
}
