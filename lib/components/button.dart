import 'package:flutter/material.dart';

class ElevateGenericButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;

  ElevateGenericButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed:
          ontapp,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black45),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
