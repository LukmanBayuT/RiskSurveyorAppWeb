import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:risk_surveyor_app/screens/svy/home_svy.dart';
import 'package:risk_surveyor_app/widget/custom_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../model/survey.dart';
import '../../utils/app_colors.dart';

class SurveyReschedule extends StatefulWidget {
  SurveyReschedule({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyRescheduleState createState() {
    return SurveyRescheduleState();
  }
}

class SurveyRescheduleState extends State<SurveyReschedule> {
  var genderOptions = [
    'Tertanggung/PIC tidak ada ditempat',
    'Tertanggung/PIC merubah jadwal',
    'Tertanggung/PIC berhalangan',
    'Tertanggung/PIC tidak tepat waktu',
    'Pindah Lokasi Survey',
    'Mobil sedang dipakai',
    'Tertanggung / PIC susah dihubungi',
    'No HP/telepon Tertanggung/PIC tidak aktif',
    'Permintaan Langsung dari Tertanggung'
  ];
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
  TextEditingController txtConReg = TextEditingController();
  TextEditingController txtConAddress = TextEditingController();

  PickResult? selectedPlace;

  bool _mapsInitialized = false;
  final String _mapsRenderer = "latest";

  void initRenderer() {
    if (_mapsInitialized) return;
    if (widget.mapsImplementation is GoogleMapsFlutterAndroid) {
      switch (_mapsRenderer) {
        case "legacy":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid).initializeWithRenderer(AndroidMapRenderer.legacy);
          break;
        case "latest":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid).initializeWithRenderer(AndroidMapRenderer.latest);
          break;
      }
    }
    setState(() {
      _mapsInitialized = true;
    });
  }

  Survey survey = Survey();
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        visible: !isExpanded,
        child: FloatingActionButton.extended(
            backgroundColor: AppColors.oonaPurple,
            label: const Text('Save'),
            icon: const FaIcon(Icons.save),
            onPressed: () async {
              save();
            }),
      ),
      appBar: const CustomAppBar(
        title: 'Request Reschedule',
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: FormBuilder(
            key: _formKey,
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            //onTap: _toggleDraggableScrollableSheet,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(color: AppColors.oonaPurple),
                                //controller: txtConHospital,
                                enabled: false,
                                name: 'surveyno',
                                initialValue: data['Sequence'].toString(),
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.receipt,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Survey Number',
                                  labelText: 'Survey Number',
                                  hintStyle: TextStyle(color: AppColors.oonaPurple),
                                  labelStyle: TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            //onTap: _toggleDraggableScrollableSheet,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(color: AppColors.oonaPurple),
                                //controller: txtConHospital,
                                enabled: false,
                                name: 'quotation',
                                initialValue: data['QuotationNo'].toString(),
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.receipt,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Quotation Number',
                                  labelText: 'Quotation Number',
                                  hintStyle: TextStyle(color: AppColors.oonaPurple),
                                  labelStyle: TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            //onTap: _toggleDraggableScrollableSheet,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderDropdown<String>(
                                style: TextStyle(
                                  color: AppColors.oonaPurple,
                                  fontSize: 8.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                dropdownColor: AppColors.grey,
                                iconEnabledColor: AppColors.oonaPurple,
                                // autovalidate: true,
                                name: 'reason',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.question_answer,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Reason',
                                  labelText: 'Reason',
                                  hintStyle: TextStyle(color: AppColors.oonaPurple),
                                  labelStyle: TextStyle(color: AppColors.oonaPurple),
                                ),
                                // initialValue: 'Male',
                                validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                                items: genderOptions
                                    .map((gender) => DropdownMenuItem(
                                          //alignment: AlignmentDirectional.center,
                                          value: gender,
                                          child: Text(gender),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {});
                                },
                                valueTransformer: (val) => val?.toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> save() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      survey.surveyStatus = 'O';
      survey.assignStatus = '04';
      survey.reasonReschedule = _formKey.currentState?.value['reason'];
      survey.aNO = data['Ano'].toString();
      survey.cNO = data['CNO'].toString();

      var chekInResponse = await survey.UpdateSurveyStatus();
      if (chekInResponse['success'] == true) {
        final result = await showOkAlertDialog(
          context: context,
          title: 'Survey Saved',
          message: 'Survey successfully saved',
          builder: (context, child) => Theme(
            data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: AppColors.oonaPurple),
              ),
            ),
            child: child,
          ),
        );
        if (result == OkCancelResult.ok) {
          Get.offAll(const HomeSVY());
        }
      } else {
        //Navigator.pop(context);
        showOkAlertDialog(context: context, title: 'claimFailed'.tr, message: chekInResponse['message'].toString().tr);
      }
    } else {
      debugPrint(_formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }
}
