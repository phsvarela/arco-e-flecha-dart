import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/constants/colors_constants.dart';
import 'package:projeto_final/constants/helper_constants.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import 'package:projeto_final/widgets/header.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Header(
              title: "Como jogar",
              showBackButton: true,
              onBackPressed: () => BlocProvider.of<NavigationBloc>(context)
                  .add(GoToConfiguration())),
          const SizedBox(
            height: 150,
          ),
          const CustomSquare(
              padding: 20,
              width: 500,
              height: 200,
              borderRadius: 20,
              children: [
                Center(
                  child: Text(HelperConstants.helperTitle,
                      style: TextStyle(
                          color: Color(ColorsConstants.text),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )
              ])
        ],
      ),
    );
  }
}
