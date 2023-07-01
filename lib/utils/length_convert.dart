class LengthConvert {
  static String intLengthtoString(int length) {
    switch (length) {
      case 1:
        return "Very Short";
      case 2:
        return "Short";
      case 3:
        return "Medium";
      case 4:
        return "Long";
      case 5:
        return "Very Long";
      default:
        return "No Data";
    }
  }
}
