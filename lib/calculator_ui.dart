import 'package:flutter/material.dart';
import 'logic.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

class CalculatorUi extends StatefulWidget {
  const CalculatorUi({super.key});

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  final Logic calclogic = Logic();
  String userInput = '';
  String result = '';

  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;

  void onButtonPressed(String value, BuildContext context, ThemeData theme) {
    setState(() {
      if (value == 'AC') {
        userInput = '';
        result = '';
      } else if (value == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  'Nothing to delete',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              duration: const Duration(seconds: 1),
              backgroundColor: theme.brightness == Brightness.light
                  ? const Color.fromARGB(255, 43, 41, 50)
                  : const Color.fromARGB(255, 41, 39, 46),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
            ),
          );
        }
      } else if (value == '=') {
        if (userInput.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please enter an expression',
                style: theme.textTheme.bodyLarge,
              ),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),

              backgroundColor: theme.brightness == Brightness.light
                  ? const Color.fromARGB(255, 24, 22, 32)
                  : const Color.fromARGB(255, 117, 95, 190),
            ),
          );
        } else {
          result = calclogic.calculate(
            userInput.replaceAll('÷', '/').replaceAll('\u00D7', '*'),
          );
        }
      } else {
        userInput += value;
      }
    });
  }

  final List<String> buttons = [
    'AC',
    'DEL',
    '÷',
    '\u00D7',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '.',
    '(',
    '0',
    ')',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'CALCULATOR',
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: theme.brightness == Brightness.light
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 250, 250, 250),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 248, 249, 249),
                  const Color.fromARGB(255, 0, 0, 0),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: isDark
                    ? const Color.fromARGB(255, 24, 3, 249)
                    : const Color.fromARGB(255, 254, 116, 2),
              ),
              onPressed: () {
                themeProvider.toggleTheme(!isDark);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.brightness == Brightness.light
                          ? const Color.fromARGB(248, 37, 5, 5)
                          : const Color.fromARGB(249, 95, 91, 91),
                      width: width * 0.005,
                    ),
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(width * 0.001),
                          alignment: Alignment.topLeft,
                          child: Text(
                            userInput,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(width * 0.001),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            result,
                            style: theme.textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: theme.brightness == Brightness.light
                    ? const Color.fromARGB(249, 0, 0, 0)
                    : const Color.fromARGB(249, 95, 91, 91),
                thickness: height * 0.004,
                endIndent: width * 0.03,
                indent: width * 0.03,
              ),
              Expanded(
                flex: 6,
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: width * 0.02,
                    crossAxisSpacing: width * 0.02,
                  ),
                  itemBuilder: (context, index) {
                    Color backgroundcolor;

                    if (buttons[index] == 'AC' || buttons[index] == 'DEL') {
                      theme.brightness == Brightness.light
                          ? backgroundcolor = const Color.fromARGB(
                              255,
                              41,
                              40,
                              40,
                            )
                          : backgroundcolor = const Color.fromARGB(
                              255,
                              20,
                              19,
                              19,
                            );
                    } else if (buttons[index] == '=') {
                      theme.brightness == Brightness.light
                          ? backgroundcolor = const Color.fromARGB(
                              255,
                              70,
                              21,
                              21,
                            )
                          : backgroundcolor = const Color.fromARGB(
                              255,
                              33,
                              2,
                              2,
                            );
                    } else if (buttons[index] == '\u00D7' ||
                        buttons[index] == '÷' ||
                        buttons[index] == '-' ||
                        buttons[index] == '+' ||
                        buttons[index] == '.' ||
                        buttons[index] == '(' ||
                        buttons[index] == ')') {
                      theme.brightness == Brightness.light
                          ? backgroundcolor = const Color.fromARGB(255, 75, 73, 82)
                          : backgroundcolor = const Color.fromARGB(255, 33, 32, 37);
                    } else {
                      theme.brightness == Brightness.light
                          ? backgroundcolor = const Color.fromARGB(
                              255,
                              145,
                              140,
                              140,
                            )
                          : backgroundcolor = const Color.fromARGB(
                              255,
                              50,
                              50,
                              50,
                            );
                    }

                    return TextButton(
                      onPressed: () {
                        onButtonPressed(buttons[index], context, theme);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: backgroundcolor,
                        //foregroundColor: theme.textButtonTheme.style?.foregroundColor?.resolve({}) ?? Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                      ),
                      child: Text(
                        buttons[index],
                        style: theme.textTheme.bodyLarge,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
