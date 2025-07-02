import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';

class ContrlCenterAddComplaint extends StatefulWidget {
  const ContrlCenterAddComplaint({super.key});

  @override
  State<ContrlCenterAddComplaint> createState() =>
      _ContrlCenterAddComplaintState();
}

class _ContrlCenterAddComplaintState extends State<ContrlCenterAddComplaint> {
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
