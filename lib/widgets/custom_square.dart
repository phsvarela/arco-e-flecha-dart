import 'package:flutter/material.dart';
import 'package:projeto_final/constants/colors_constants.dart';

class CustomSquare extends StatelessWidget {
  final List<Widget> children;
  final double padding;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double borderRadius;

  const CustomSquare({
    super.key,
    required this.padding,
    this.onTap,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: const Color(ColorsConstants.primary),
          border: Border.all(
            color: const Color(ColorsConstants.secondary),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),        
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}
