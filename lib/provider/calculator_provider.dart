import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculateProvider extends ChangeNotifier {
  String _displayText = "0";
  String get displayText => _displayText;

  // Define a set of operators for easy checking
  final Set<String> _operators = {'+', '-', '*', '/', '%', '+/-', 'x'};

  void setValue(String value) {
    if (value == "AC") {
      _displayText = "0";
    } else if (_displayText == "0") {
      // Prevent the display from starting with an operator
      if (!_operators.contains(value)) {
        _displayText = value;
      }
    } else {
      // Prevent double operators
      if (_operators.contains(value) &&
          _operators.contains(_displayText[_displayText.length - 1])) {
        // Do nothing if the last character and the current value are both operators
        return;
      }

      switch (value) {
        case "x":
          // If the last character is an operator, replace it with the new operator
          if (_operators.contains(_displayText[_displayText.length - 1])) {
            _displayText =
                "${_displayText.substring(0, _displayText.length - 1)}*";
          } else {
            _displayText += "*";
          }
          break;
        case "=":
          calculate();
          break;
        case "+/-":
          toggleSign();
          break;
        default:
          // If the last character is an operator, replace it with the new operator
          if (_operators.contains(value) &&
              _operators.contains(_displayText[_displayText.length - 1])) {
            _displayText =
                _displayText.substring(0, _displayText.length - 1) + value;
          } else {
            _displayText += value;
          }
      }
    }
    notifyListeners();
  }

  void calculate() {
    try {
      String expression = _displayText.replaceAll("x", "*");
      num result = expression.interpret();
      _displayText = result == result.toInt()
          ? result.toInt().toString()
          : result.toString();
    } catch (e) {
      _displayText = "Error";
    }
    notifyListeners();
  }

  void toggleSign() {
    if (_displayText.isNotEmpty &&
        !_operators.contains(_displayText[_displayText.length - 1])) {
      if (_displayText.startsWith('-')) {
        _displayText = _displayText.substring(1);
      } else {
        _displayText = '-$_displayText';
      }
    }
    notifyListeners();
  }
}
