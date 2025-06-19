import 'package:flutter/material.dart';
import '../constent/app_constant.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/all_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarSection(),







            ],
          ),
        ),
      ),
    );
  }
}
