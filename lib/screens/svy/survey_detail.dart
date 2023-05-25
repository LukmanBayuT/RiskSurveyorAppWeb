import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/screens/svy/survey_form.dart';
import 'package:risk_surveyor_app/screens/svy/survey_reschedule.dart';
import 'package:risk_surveyor_app/screens/svy/survey_tw_form.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class SurveyDetail extends StatefulWidget {
  const SurveyDetail({super.key});

  @override
  State<SurveyDetail> createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "SURVEY DETAIL",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        nextBtn: false,
        onBack: () {
          Get.back();
        },
      ),
      body: ListView.builder(
        padding: AppDimension.mainPadding,
        itemCount: 1,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        InkWell(
          child: Card(
            color: AppColors.grey30,
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Survey Number",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['Sequence'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Quotation Number",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['QuotationNo'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Survey Location",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['SurveyAddress'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    trailing: const FaIcon(
                      Icons.location_on,
                      color: AppColors.oonaPurple,
                    ),
                    onTap: () {
                      MapsLauncher.launchQuery(
                        data['SurveyAddress'].toString(),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Survey Location Detail",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['SurveyAddressDetail'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Survey PIC",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['PICSurvey'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      "Survey Phone",
                      style: TextStyle(
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    subtitle: Text(
                      data['PICPhone'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oonaPurple,
                        fontSize: AppDimension.fontSizeSmall,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse("tel://${data['PICPhone'].toString()}"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5.h,
              width: 35.w,
              child: ElevatedButton(
                //textColor: const Color(0xFF6200EE),
                onPressed: () async {
                  final Directory appPath = await getApplicationDocumentsDirectory();
                  final String newPath = '${appPath.path}/${data['QuotationNo']}';
                  if(!Directory('$newPath').existsSync()){
                    Directory('$newPath').create(recursive: true);
                  }
                  Get.to(SurveyForm(), arguments: data);
                },
                child: Text(
                  'START SURVEY',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimension.fontSizeSmall,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
              width: 35.w,
              child: ElevatedButton(
                //textColor: const Color(0xFF6200EE),
                onPressed: () async {
                  Get.to(SurveyReschedule(), arguments: data);
                },
                child: Text(
                  'RESCHEDULE',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimension.fontSizeSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
