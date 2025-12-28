import '../models/calculator_model.dart';
import '../models/history_item.dart';
import '../utils/time_format.dart';
import 'history_controller.dart';

enum Operation { add, subtract, multiply, divide }

class CalculatorController {
  final CalculatorModel model;
  final HistoryController historyController;

  CalculatorController(this.model, {HistoryController? historyController})
      : historyController = historyController ?? HistoryController();

  void updateFirstNumber(String value) {
    model.firstNumber = double.tryParse(value) ?? 0;
  }

  void updateSecondNumber(String value) {
    model.secondNumber = double.tryParse(value) ?? 0;
  }

  Future<void> calculate(Operation operation) async {
    model.error = null;

    final a = model.firstNumber;
    final b = model.secondNumber;

    String opSymbol;

    switch (operation) {
      case Operation.add:
        model.result = a + b;
        opSymbol = '+';
        break;
      case Operation.subtract:
        model.result = a - b;
        opSymbol = '-';
        break;
      case Operation.multiply:
        model.result = a * b;
        opSymbol = '*';
        break;
      case Operation.divide:
        opSymbol = '/';
        if (b == 0) {
          model.error = 'Viga: jagamine nulliga';
          model.result = 0;
        } else {
          model.result = a / b;
        }
        break;
    }

    // Salvesta ainult siis, kui viga pole
    if (model.error == null) {
      final expression =
          '${_pretty(a)} $opSymbol ${_pretty(b)} = ${_pretty(model.result)}';
      final timestamp = formatTimestamp(DateTime.now());

      try {
        await historyController.addHistoryItem(
          HistoryItem(expression: expression, timestamp: timestamp),
        );
      } catch (_) {
        
      }
    }
  }

  String getResultText() {
    if (model.error != null) return model.error!;
    return _pretty(model.result);
  }

  String _pretty(double value) {
    // Võtab ära .0 kui täisarv
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toString();
  }
}
