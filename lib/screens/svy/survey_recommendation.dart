import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:risk_surveyor_app/screens/svy/report.dart';
import 'package:risk_surveyor_app/screens/svy/scroll_test.dart';
import 'package:risk_surveyor_app/screens/svy/survey_report.dart';

import '../../model/pdf.dart';
import '../../model/survey_result.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class SurveyRecommendation extends StatefulWidget {
  SurveyRecommendation({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyRecommendationState createState() {
    return SurveyRecommendationState();
  }
}

class SurveyRecommendationState extends State<SurveyRecommendation> {
  GoogleMapController? mapController;
  final _formKey = GlobalKey<FormBuilderState>();
  List<Widget> providerList = [];
  TextEditingController textEditingController = TextEditingController();
  late BuildContext draggableSheetContext;
  double minExtent = 0;
  static const double maxExtent = 1;
  bool isExpanded = false;
  double initialExtent = 0;
  TextEditingController txtConHospital = TextEditingController();
  TextEditingController txtConAddress = TextEditingController();

  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        nextBtn: true,
        onBack: () {
          Get.back();
        },
        onNext: () async {
          next();
        },
      ),
      appBar: const CustomAppBar(
        title: 'SURVEY FORM',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.5 * AppDimension.blockSizeVertical, horizontal: 0.5 * AppDimension.blockSizeHorizontal),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Column(
                      children: [
                        Card(
                          color: AppColors.grey30,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Survey Summary',
                                  style: TextStyle(
                                    fontSize: AppDimension.fontSizeSmall,
                                    color: AppColors.oonaPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: FormBuilderTextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      //controller: txtConHospital,
                                      enabled: true,
                                      name: 'surveyRec',
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Survey Recommendation',
                                        hintText: 'Survey Recommendation',
                                        hintStyle: TextStyle(fontSize: AppDimension.fontSizeSmall, color: Colors.black),
                                        labelStyle: TextStyle(fontSize: AppDimension.fontSizeSmall, color: Colors.black),
                                      ),
                                      validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: FormBuilderTextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      //controller: txtConHospital,
                                      enabled: true,
                                      name: 'PICresponse',
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'PIC Response',
                                        hintText: 'PIC Response',
                                        hintStyle: TextStyle(fontSize: AppDimension.fontSizeSmall, color: AppColors.oonaPurple),
                                        labelStyle: TextStyle(fontSize: AppDimension.fontSizeSmall, color: AppColors.oonaPurple),
                                      ),
                                      validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  next() async {
    _formKey.currentState!.save();
    //surveyResult.checklist?.addAll(_formKey.currentState!.value);
    surveyResult.recommendation = _formKey.currentState?.value['surveyRec'].toString();
    surveyResult.response = _formKey.currentState?.value['PICresponse'].toString();
    surveyResult.checkAutoRelease(data['AutoReleaseF'].toString());
    await pdf().generateExampleDocument(data, surveyResult);
    Get.to(SurveyReport(), arguments: [data,surveyResult]);
  }
}
