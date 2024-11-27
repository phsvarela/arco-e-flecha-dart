import 'package:flutter/material.dart';
import 'package:projeto_final/constants/colors_constants.dart';
import 'package:projeto_final/widgets/custom_square.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSquare(
      padding: 100,
      width: 500,
      height: 300,
      borderRadius: 20,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Tiro ao alvo",
            style: TextStyle(
              color: Color(ColorsConstants.text),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
