import 'package:bloc/bloc.dart';
import 'package:hello_world/feature/app/data/validation/expression.dart';
import 'package:meta/meta.dart';
import 'package:eval_ex/expression.dart';

part './calculator_expression_state.dart';

class CaluclatorExpressionCubit extends Cubit<CaluclatorExpressionState> {
  ExpressionValidator validator =  new ExpressionValidator();
  CaluclatorExpressionCubit() : super(
      CaluclatorExpressionState(
        expression: "",
        wasEvaluated: false,
        solvedExpression: ""
    )
  );

  String evalExpression(String expression) {
    Expression exp = Expression(expression);
    String finalExpression;
    try {
      finalExpression = (exp.eval().toString());
    } on Exception catch (_) {
      finalExpression =  expression;
    }
    return finalExpression;
  }

  String safeNewExpression(String newExpression) {
    String safeExpression;
    if (validator.isValidExpression(newExpression))
      safeExpression = newExpression;
    else
      safeExpression = state.expression;
    return safeExpression;
  }

  void update(newExpression) => emit(
    CaluclatorExpressionState(
        expression: state.expression = safeNewExpression(newExpression),
        wasEvaluated: false,
        solvedExpression: evalExpression( safeNewExpression(newExpression) )
    )
  );

  void solve(newExpression) => emit(
      CaluclatorExpressionState(
          expression: state.expression = state.solvedExpression,
          wasEvaluated: true,
          solvedExpression: state.solvedExpression
      )
  );

  void solveNotEvaluate(newExpression) => emit(
    CaluclatorExpressionState(
      expression: state.expression = state.solvedExpression,
      wasEvaluated: false,
        solvedExpression: state.solvedExpression
    ),
  );
}