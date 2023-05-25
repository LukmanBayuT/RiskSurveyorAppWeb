import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:risk_surveyor_app/screens/svy/survey_document.dart';
import 'package:risk_surveyor_app/widget/custom_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../model/gentab.dart';
import '../../model/survey_result.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_fab.dart';

class SurveyForm extends StatefulWidget {
  SurveyForm({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyFormState createState() {
    return SurveyFormState();
  }
}

class SurveyFormState extends State<SurveyForm> {
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
  var data = Get.arguments;
  SurveyResult surveyResult = SurveyResult();
  List<String> zone = [];
  List<String> relation = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        nextBtn: true,
        onNext: () {
          next();
        },
        onBack: () {
          Get.back();
        },
      ),
      appBar: const CustomAppBar(
        title: 'SURVEY FORM',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: AppDimension.mainPadding,
              child: FormBuilder(
                key: _formKey,
                child: FutureBuilder(
                  future: GetGenTab(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Card(
                            color: AppColors.grey30,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Insured Data',
                                    style: TextStyle(
                                      fontSize: AppDimension.fontSizeSmall,
                                      color: AppColors.oonaPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['Name'],
                                        enabled: false,
                                        name: 'pHolder',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Policy Holder',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['AName'],
                                        enabled: false,
                                        name: 'insuredName',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Insured Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['Address_1'],
                                        enabled: false,
                                        name: 'insuredAddress',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Insured Address',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: AppColors.grey30,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Survey Data',
                                    style: TextStyle(
                                      fontSize: AppDimension.fontSizeSmall,
                                      color: AppColors.oonaPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['SurveyAddress'],
                                        enabled: false,
                                        name: 'surveyLocation',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Survey Location',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['PICSurvey'],
                                        enabled: false,
                                        name: 'PIC',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Survey PIC',
                                        ),
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
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        enabled: true,
                                        name: 'actualPic',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Actual Survey PIC',
                                          hintStyle: TextStyle(color: Colors.black),
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'Kolom ini harus terisi'),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['PICRelation'],
                                        enabled: false,
                                        name: 'PICRelation',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Relation with Insured',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderDropdown<String>(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                          color: Colors.black,
                                        ),
                                        dropdownColor: AppColors.grey,
                                        iconEnabledColor: AppColors.oonaPurple,
                                        // autovalidate: true,
                                        name: 'actualPicRelation',
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Actual Survey PIC Relation',
                                          labelText: 'Actual Survey PIC Relation',
                                          hintStyle: TextStyle(color: AppColors.oonaPurple, fontSize: AppDimension.fontSizeSmall),
                                          labelStyle: TextStyle(color: AppColors.oonaPurple, fontSize: AppDimension.fontSizeSmall),
                                        ),
                                        // initialValue: 'Male',
                                        validator: FormBuilderValidators.required(errorText: 'Kolom ini harus terisi'),
                                        items: relation
                                            .map((region) => DropdownMenuItem(
                                                  //alignment: AlignmentDirectional.center,
                                                  value: region,
                                                  child: Text(region),
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
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC1'],
                                        enabled: false,
                                        name: 'vehicleBrand',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Brand',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC2'],
                                        enabled: false,
                                        name: 'vehicleModel',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Model',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC3'],
                                        enabled: false,
                                        name: 'vehicleType',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Type',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC11'],
                                        enabled: false,
                                        name: 'vehicleSubModel',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Sub Model',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC4'],
                                        enabled: false,
                                        name: 'vehicleLicenseNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle License Number',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC6'],
                                        enabled: false,
                                        name: 'vehicleChassisNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Chassis Number',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC5'],
                                        enabled: false,
                                        name: 'vehicleMachineNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Cehicle Machine Number',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC10'],
                                        enabled: false,
                                        name: 'vehicleColor',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Color',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC7'],
                                        enabled: false,
                                        name: 'vehicleFunction',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Function',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['VALUEDESC15'],
                                        enabled: false,
                                        name: 'vehicleGroup',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Group',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: AppColors.grey30,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Coverage Data',
                                    style: TextStyle(
                                      fontSize: AppDimension.fontSizeSmall,
                                      color: AppColors.oonaPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['TSI'],
                                        enabled: false,
                                        name: 'TSI',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Total Sum Insured',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['MCoverage'],
                                        enabled: false,
                                        name: 'MCoverage',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Main Coverage',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['Equipment'],
                                        enabled: false,
                                        name: 'nonStandardEQ',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Non Standard Equipment',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: FormBuilderTextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        initialValue: data['ACoverage'],
                                        enabled: false,
                                        name: 'ACoverage',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Additional Coverage',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> GetGenTab() async {
    zone = await GenTab().GetZone();
    relation = await GenTab().GetRelation();
  }

  void next() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      surveyResult.actualPic = _formKey.currentState?.value['actualPic'].toString();
      surveyResult.actualPicRelation = _formKey.currentState?.value['actualPicRelation'].toString();
      if(surveyResult.actualPic != _formKey.currentState?.value['PIC'].toString() || surveyResult.actualPicRelation != _formKey.currentState?.value['PICRelation'].toString()){
        surveyResult.redFlag = "1";
      } else {
        surveyResult.redFlag = "0";
      }
      surveyResult.loadChecklistFromJsonFile(data['QuotationNo'].toString());
      Get.to(const SurveyDocument(), arguments: [data, surveyResult]);
    } else {
      debugPrint(_formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }
}
