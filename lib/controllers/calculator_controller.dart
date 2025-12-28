import '../models/calculator_model.dart';

enum Operation { add, subtract, multiply, divide }

class CalculatorController {
  final CalculatorModel model;

  CalculatorController(this.model);

  // Sisendi uuendamine (string -> double)
  void updateFirstNumber(String value) {
    model.firstNumber = double.tryParse(value) ?? 0;
  }

  void updateSecondNumber(String value) {
    model.secondNumber = double.tryParse(value) ?? 0;
  }

  // Põhitehted
  void calculate(Operation operation) {
    model.error = null; 

    switch (operation) {
      case Operation.add:
        model.result = model.firstNumber + model.secondNumber;
        break;
      case Operation.subtract:
        model.result = model.firstNumber - model.secondNumber;
        break;
      case Operation.multiply:
        model.result = model.firstNumber * model.secondNumber;
        break;
      case Operation.divide:
        if (model.secondNumber == 0) {
          model.error = 'Viga: jagamine nulliga';
          model.result = 0;
        } else {
          model.result = model.firstNumber / model.secondNumber;
        }
        break;
    }
  }

  
  String getResultText() {
    if (model.error != null) {
      return model.error!;
    }
    return model.result.toString();
  }
}
