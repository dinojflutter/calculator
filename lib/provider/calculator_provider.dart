import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculateProvider extends ChangeNotifier {
  String _displayText = "0";
  String get displayText => _displayText;

  void setValue(String value) {
    if (value == "AC") {
      _displayText = "0";
    } else if (displayText == "0" && value != "=") {
      _displayText = value;
    } else if (value == "x") {
      _displayText += "*";
    } else if (value == "=") {
      calculate();
    } else {
      _displayText += value;
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
}


    // switch (value) {
    //     case "x":
    //       _displayText += "*";
    //       break;
    //     case "=":
    //       calculate();
    //       break;
    //     default:
    //       _displayText += value;
    //   }