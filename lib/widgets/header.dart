import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/constants/colors_constants.dart';
import 'package:projeto_final/widgets/custom_square.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool isMainMenu;

  const Header({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.isMainMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          CustomSquare(
            padding: 20,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 70,
            borderRadius: 20,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(ColorsConstants.text),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (showBackButton)
            Positioned(
              left: 10,
              top: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color(ColorsConstants.secondary)),
                onPressed: onBackPressed,
              ),
            ),
          if (isMainMenu)
            Positioned(
              right: 10,
              top: 20,
              child: IconButton(
                icon: const Icon(Icons.settings,
                    color: Color(ColorsConstants.text)),
                onPressed: () => BlocProvider.of<NavigationBloc>(context)
                    .add(GoToConfiguration()),
              ),
            ),
        ],
      ),
    );
  }
}
