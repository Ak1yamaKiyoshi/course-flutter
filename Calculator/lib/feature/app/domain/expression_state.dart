part of 'expression_cubit.dart';

class CaluclatorExpressionState {
  String expression = "";
  bool wasEvaluated = false;
  String solvedExpression = "";

  CaluclatorExpressionState({
    required this.expression,
    required this.wasEvaluated,
    required this.solvedExpression
  });
}