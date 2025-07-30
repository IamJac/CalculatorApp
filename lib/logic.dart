import 'package:math_expressions/math_expressions.dart';

class Logic {
  String calculate(String userInput) {
    try {
      ShuntingYardParser parser = ShuntingYardParser();
      Expression exp = parser.parse(userInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error-${e.toString()}';
    }
  }
}
