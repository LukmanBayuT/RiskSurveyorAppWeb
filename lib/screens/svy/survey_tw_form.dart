import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:risk_surveyor_app/screens/svy/survey_document.dart';
import 'package:risk_surveyor_app/widget/custom_appbar.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_fab.dart';

class SurveyTwForm extends StatefulWidget {
  SurveyTwForm({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyTwFormState createState() {
    return SurveyTwFormState();
  }
}

class SurveyTwFormState extends State<SurveyTwForm> {
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
  int sIndex = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // _formKey.currentState?.patchValue({
    //   'pic':'Putra Rizki Pradana',
    //   'insuredName':'Putra Rizki Pradana',
    //   'insuredAddress':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
    //   'surveyLocation':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190'
    // });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        nextBtn: true,
        onNext: () {
          Get.to(const SurveyDocument(), arguments: sIndex);
        },
        onBack: () {
          Get.back();
        },
      ),
      appBar: const CustomAppBar(
        title: 'Survey Form',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: AppDimension.mainPadding,
              child: FormBuilder(
                key: _formKey,
                child: FutureBuilder(
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
                                        initialValue: 'Putra Rizki Pradana',
                                        enabled: false,
                                        name: 'pHolder',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Policy Holder',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Putra Rizki Pradana',
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
                                        initialValue:
                                        'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
                                        enabled: false,
                                        name: 'insuredAddress',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Insured Address',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue:
                                        'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
                                        enabled: false,
                                        name: 'surveyLocation',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Survey Location',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Rizki',
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
                                        name: 'actualPIC',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Actual Survey PIC',
                                          hintStyle: TextStyle(color: Colors.black),
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Sibling',
                                        enabled: false,
                                        name: 'PICRelation',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Relation with Insured',
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
                                        style: TextStyle(
                                          fontSize: AppDimension.fontSizeSmall,
                                        ),
                                        enabled: true,
                                        name: 'actualPICRelation',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Actual Survey PIC Relation with Insured',
                                          hintStyle: TextStyle(color: Colors.black),
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Honda',
                                        enabled: false,
                                        name: 'vehicleBrand',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Relation with Insured',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'PCX',
                                        enabled: false,
                                        name: 'vehicleModel',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Model',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Hybrid',
                                        enabled: false,
                                        name: 'vehicleType',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Type',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Honda PCX Hybrid',
                                        enabled: false,
                                        name: 'vehicleSubModel',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Cehicle Sub Model',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'B2015FIH',
                                        enabled: false,
                                        name: 'vehicleLicenseNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle License Number',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'S6UZQS7W419SQW7UE',
                                        enabled: false,
                                        name: 'vehicleChassisNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Chassis Number',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'S6UZQS7W',
                                        enabled: false,
                                        name: 'vehicleMachineNumber',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Machine Number',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Blue Doff',
                                        enabled: false,
                                        name: 'vehicleColor',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Color',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Personal Use',
                                        enabled: false,
                                        name: 'vehicleFunction',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Function',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'Motorcycle',
                                        enabled: false,
                                        name: 'vehicleGroup',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Vehicle Group',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: '40000000',
                                        enabled: false,
                                        name: 'TSI',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Total Sum Insured',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: 'TLO',
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
                                        initialValue: 'Shockbreaker',
                                        enabled: false,
                                        name: 'nonStandardEQ',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Non Standard Equipment',
                                        ),
                                        validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
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
                                        initialValue: '-',
                                        enabled: false,
                                        name: 'ACoverage',
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            color: AppColors.oonaPurple,
                                          ),
                                          labelText: 'Additional Coverage',
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
}
