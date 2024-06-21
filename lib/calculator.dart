import 'dart:async';

import 'package:calculator/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Map<String, bool> buttonstate = {};

  void handleTap(String text) {
    setState(() {
      buttonstate[text] = true;
    });

    Provider.of<CalculateProvider>(context, listen: false).setValue(text);
    Timer(const Duration(milliseconds: 70), () {
      setState(() {
        buttonstate[text] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculateProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  provider.displayText,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttontext(Colors.grey, "AC", Colors.white),
                buttontext(Colors.grey, "+/-", Colors.white),
                buttontext(Colors.grey, "%", Colors.white),
                buttontext(Colors.orange, "/", Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttontext(Colors.grey, "7", Colors.white),
                buttontext(Colors.grey, "8", Colors.white),
                buttontext(Colors.grey, "9", Colors.white),
                buttontext(Colors.orange, "x", Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttontext(Colors.grey, "4", Colors.white),
                buttontext(Colors.grey, "5", Colors.white),
                buttontext(Colors.grey, "6", Colors.white),
                buttontext(Colors.orange, "-", Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttontext(Colors.grey, "1", Colors.white),
                buttontext(Colors.grey, "2", Colors.white),
                buttontext(Colors.grey, "3", Colors.white),
                buttontext(Colors.orange, "+", Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      handleTap("0");
                    },
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                ),
                buttontext(Colors.grey, ",", Colors.white),
                buttontext(Colors.grey, "=", Colors.white),
              ],
            ),
          ],
        )),
      );
    });
  }

  Widget buttontext(
    Color bgcolor,
    String text,
    Color textcolor,
  ) {
    bool iscolorChanged = buttonstate[text] ?? false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => handleTap(text),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: iscolorChanged ? Colors.white : bgcolor,
              shape: BoxShape.circle),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, color: textcolor),
            ),
          ),
        ),
      ),
    );
  }
}
