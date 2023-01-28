import 'package:flutter/material.dart';
import 'package:showpassword/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontFamily: 'PTMono', fontSize: 18);
    return MaterialApp(
      title: 'Show Password',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(bodyMedium: style),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: style,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      home: const SignUp(),
    );
  }
}
