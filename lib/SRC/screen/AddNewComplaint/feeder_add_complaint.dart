import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';

class FeederAddComplaint extends StatefulWidget {
  const FeederAddComplaint({super.key});

  @override
  State<FeederAddComplaint> createState() => _FeederAddComplaintState();
}

class _FeederAddComplaintState extends State<FeederAddComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              AppBarSection(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // add comming soon text
                  const SizedBox(height: 50),
                  Text(
                    "Coming Soon",
                    style: AppTextStyles.title,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
