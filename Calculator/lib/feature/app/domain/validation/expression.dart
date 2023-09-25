class ExpressionValidator {
  bool isValidExpression(String expression) {
    Set <bool> isValid = {
      RegExp(r'[\-+%\/*]{2,}').hasMatch(expression),
      RegExp(r'^[+%\/*]').hasMatch(expression),
      RegExp('[^0-9+\-/*+]').hasMatch(expression),
    };
    return !isValid.contains(true);
  }
}
