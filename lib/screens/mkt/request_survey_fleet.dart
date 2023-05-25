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
import 'package:intl/intl.dart';
import 'package:risk_surveyor_app/screens/mkt/home_mkt.dart';
import 'package:sizer/sizer.dart';

import '../../model/survey.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class RequestSurveyFleet extends StatefulWidget {
  RequestSurveyFleet({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  RequestSurveyFleetState createState() {
    return RequestSurveyFleetState();
  }
}

class RequestSurveyFleetState extends State<RequestSurveyFleet> {
  GoogleMapController? mapController;
  final _formKey = GlobalKey<FormBuilderState>();
  List<Widget> providerList = [];
  TextEditingController textEditingController = TextEditingController();
  late BuildContext draggableSheetContext;
  double minExtent = 0;
  static const double maxExtent = 1;
  bool isExpanded = false;
  double initialExtent = 0;
  TextEditingController txtConQuotation = TextEditingController();
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

  Survey survey = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "REQUEST SURVEY",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        customBtn: true,
        onBack: () {
          Get.to(Home());
        },
        btn: [
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () async {
                next();
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          padding: AppDimension.mainPadding,
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
                                //controller: txtConQuotation,
                                enabled: false,
                                initialValue: survey.quotationNo,
                                name: 'quotation',
                                decoration: const InputDecoration(
                                  icon: FaIcon(Icons.receipt, color: AppColors.oonaPurple),
                                  border: InputBorder.none,
                                  hintText: 'Quotation No',
                                  labelText: 'Quotation No',
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
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(color: AppColors.oonaPurple),
                                keyboardType: TextInputType.multiline,
                                //minLines: 5,
                                maxLines: null,
                                //controller: txtConHospital,
                                enabled: true,
                                name: 'remark',
                                decoration: const InputDecoration(
                                  icon: FaIcon(Icons.comment, color: AppColors.oonaPurple),
                                  border: InputBorder.none,
                                  hintText: 'Survey Request For Fleet',
                                  labelText: 'Survey Request For Fleet',
                                  hintStyle: TextStyle(color: AppColors.oonaPurple),
                                  labelStyle: TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(errorText: 'mustFilled'.tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DraggableScrollableActuator(
                      child: DraggableScrollableSheet(
                        key: Key(initialExtent.toString()),
                        initialChildSize: initialExtent,
                        minChildSize: minExtent,
                        maxChildSize: maxExtent,
                        builder: (BuildContext c, s) {
                          draggableSheetContext = context;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(0),
                                top: Radius.circular(20),
                              ),
                            ),
                            child: ListView(
                              controller: s,
                              children: [
                                ListTile(
                                  title: TextField(
                                    textInputAction: TextInputAction.search,
                                    controller: textEditingController,
                                    decoration: const InputDecoration(hintText: 'Search'),
                                    onSubmitted: _onSearchTextChanged,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                                Column(
                                  children: providerList,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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

  Future<void> next() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      survey.requestID = 'marketing';
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      survey.requestDate = formattedDate;
      survey.surveyType = "11";
      survey.surveyStatus = "O";
      survey.assignStatus = "01";
      survey.remark = _formKey.currentState?.value['remark'];
      survey.surveyDate = formattedDate;


      var chekInResponse = await survey.SubmitRequest();
      if (chekInResponse['success'] == true) {
        final result = await showOkAlertDialog(
          context: context,
          title: 'Survey Request Saved',
          message: 'Survey request successfully saved',
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
          Get.offAll(const Home());
        }
      } else {
        //Navigator.pop(context);
        showOkAlertDialog(context: context, title: 'claimFailed'.tr, message: chekInResponse['message'].toString().tr);
      }

    } else {
    }
  }

  void _toggleDraggableScrollableSheet() {

    providerList.clear();
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());
      initialExtent = isExpanded ? 0 : 1;
      minExtent = isExpanded ? 0 : 1;
      isExpanded = !isExpanded;
    });
    DraggableScrollableActuator.reset(draggableSheetContext);
  }


  Future<void> _onSearchTextChanged(String text) async {
    List<dynamic> data = [];
    providerList.clear();
    if (text.contains('qs')) {
      data.insert(0, {'PROVIDERNAME': 'QS11111'.tr, 'Address': ''.tr, 'PNO': ''});
      data.insert(1, {'PROVIDERNAME': 'QS22222'.tr, 'Address': ''.tr, 'PNO': ''});
      data.insert(2, {'PROVIDERNAME': 'QS33333'.tr, 'Address': ''.tr, 'PNO': ''});
    } else {
      data.insert(0, {'PROVIDERNAME': 'DKI Jakarta'.tr, 'Address': ''.tr, 'PNO': ''});
      data.insert(1, {'PROVIDERNAME': 'Jawa Barat'.tr, 'Address': ''.tr, 'PNO': ''});
      data.insert(2, {'PROVIDERNAME': 'Jawa Tengah'.tr, 'Address': ''.tr, 'PNO': ''});
      data.insert(3, {'PROVIDERNAME': 'Jawa Timur'.tr, 'Address': ''.tr, 'PNO': ''});
    }
    for (var element in data) {
      ListTile provider = ListTile(
        title: Text(
          element['PROVIDERNAME'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(element['Address']),
        //trailing: FaIcon(FontAwesomeIcons.mapPin),
        onTap: () async {
          if (text.contains('qs')) {
            if (element['PROVIDERNAME'].toString().contains("33333")) {
              _toggleDraggableScrollableSheet();
              //Get.to(RequestSurveyFleetFleet());
            } else {
              _toggleDraggableScrollableSheet();
              txtConQuotation.text = element['PROVIDERNAME'].toString();
            }
          } else {
            _toggleDraggableScrollableSheet();
            txtConReg.text = element['PROVIDERNAME'].toString();
          }
        },
      );

      setState(() {
        providerList.add(provider);
      });
    }
  }

//
//   Future<void> _getClaimTypeDd() async {
//     List<DropdownMenuItem<String>> dd = [];
//     Map<String, dynamic> result = await _account.getBenefitProductKind();
//     List<dynamic> benefit = result['data'];
//     for (var element in benefit) {
//       dd.add(
//         DropdownMenuItem(
//           value: element.toString(),
//           child: Text(
//             element.toString().tr,
//           ),
//         ),
//       );
//     }
//     _claimTypeDd = dd;
//   }
//
// // Future<void> _onClaimTypeChanged(String text) async {
// //   providerList.clear();
// //   Map<String, dynamic> result = await _account.getBenefit();
// //   Map<String, List<dynamic>> allBenefit = result['data'];
// //   List? selectedBenefit = allBenefit[text];
// //   Logger().d(selectedBenefit);
// //   for (var element in selectedBenefit!) {
// //     Widget provider = Card(
// //       child: Column(
// //         children: [
// //           ListTile(
// //             title: Text(
// //               element['BENEFIT NAME'],
// //               style: TextStyle(fontWeight: FontWeight.bold),
// //             ),
// //             subtitle: Text('limit:'.tr + ' ' + element['ASCHARGE LIMIT']),
// //             onTap: () {},
// //             tileColor: Theme.of(context).primaryColor,
// //           ),
// //           Container(
// //             padding: EdgeInsets.symmetric(horizontal: 13),
// //             child: FormBuilderTextField(
// //               name: element['BenefitID']+'Bill',
// //               decoration: InputDecoration(
// //                 icon: FaIcon(Icons.money),
// //                 border: InputBorder.none,
// //                 hintText: 'billed'.tr,
// //                 labelText: 'billed'.tr,
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //     setState(() {
// //       providerList.add(provider);
// //     });
// //   }
// // }
// }
//
// class LoadingIndicator extends StatelessWidget {
//   LoadingIndicator({this.text = ''});
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     var displayedText = text;
//
//     return Container(
//         padding: EdgeInsets.all(16),
//         color: Colors.white,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [_getLoadingIndicator(), _getHeading(context), _getText(displayedText)]));
//   }
//
//   Padding _getLoadingIndicator() {
//     return Padding(
//         child: Container(child: CircularProgressIndicator(strokeWidth: 3), width: 32, height: 32),
//         padding: EdgeInsets.only(bottom: 16));
//   }
//
//   Widget _getHeading(context) {
//     return Padding(
//         child: Text(
//           'pleaseWait'.tr,
//           style: TextStyle(color: Colors.black, fontSize: 16),
//           textAlign: TextAlign.center,
//         ),
//         padding: EdgeInsets.only(bottom: 4));
//   }
//
//   Text _getText(String displayedText) {
//     return Text(
//       displayedText,
//       style: TextStyle(color: Colors.black, fontSize: 16),
//       textAlign: TextAlign.center,
//     );
//   }
}
