import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:risk_surveyor_app/screens/svy/report.dart';
import 'package:risk_surveyor_app/screens/svy/scroll_test.dart';

import '../../model/survey_result.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class SurveyReport extends StatefulWidget {
  SurveyReport({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyReportState createState() {
    return SurveyReportState();
  }
}

class SurveyReportState extends State<SurveyReport> {
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
    // _formKey.currentState?.patchValue({
    //   'pic':'Putra Rizki Pradana',
    //   'insuredName':'Putra Rizki Pradana',
    //   'insuredAddress':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
    //   'surveyLocation':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190'
    // });
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        nextBtn: true,
        onBack: () {
          Get.back();
        },
        onNext: () {
          Get.to(const ScrollTest(), arguments: [data, surveyResult]);
        },
      ),
      appBar: const CustomAppBar(
        title: 'SURVEY FORM',
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfView(path: "/data/user/0/id.myoona.risksurveyorapp/app_flutter/${data['QuotationNo']}/SurveyReport.pdf"),
          ),
        ],
      ),
    );


  }
  String getPDFPath(){
    return "/data/user/0/id.myoona.risksurveyorapp/app_flutter/${data['QuotationNo']}/SurveyReport.pdf";
  }
}