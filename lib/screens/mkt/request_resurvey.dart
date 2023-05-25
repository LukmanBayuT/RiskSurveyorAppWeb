import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:intl/intl.dart';
import 'package:map_picker/map_picker.dart';
import 'package:risk_surveyor_app/model/quotation.dart';
import 'package:risk_surveyor_app/model/survey.dart';
import 'package:risk_surveyor_app/model/util.dart';
import 'package:risk_surveyor_app/screens/mkt/request_survey_fleet.dart';
import 'package:risk_surveyor_app/utils/app_dimension.dart';
import 'package:sizer/sizer.dart';

import '../../model/gentab.dart';
import '../../utils/app_colors.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';
import 'home_mkt.dart';

class RequestReSurvey extends StatefulWidget {
  RequestReSurvey({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;

  @override
  RequestReSurveyState createState() {
    return RequestReSurveyState();
  }
}

class RequestReSurveyState extends State<RequestReSurvey> {
  Survey survey = Survey();
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
  List<String> zone = [];
  List<String> relation = [];

  bool _mapsInitialized = false;
  final String _mapsRenderer = "latest";

  void initRenderer() {
    if (_mapsInitialized) return;
    if (widget.mapsImplementation is GoogleMapsFlutterAndroid) {
      switch (_mapsRenderer) {
        case "legacy":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.legacy);
          break;
        case "latest":
          (widget.mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.latest);
          break;
      }
    }
    setState(() {
      _mapsInitialized = true;
    });
  }

  final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyA2PObNCiBHb5k-DU3HV-ivGId1mPnCP4A',
    language: 'en',
    countryCode: 'us',
    countryCodes: ['us', 'es', 'co'],
    country: 'Indonesia',
    city: 'Jakarta',
  );

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(-6.2254512, 106.8025882),
    zoom: 14.4746,
  );

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "REQUEST RE-SURVEY",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        customBtn: true,
        onBack: () {
          Get.back();
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
          width: 100.w,
          height: 100.h,
          padding: AppDimension.mainPadding,
          child: FormBuilder(
            key: _formKey,
            child: FutureBuilder(
              future: GetGenTab(),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                onTap: _toggleDraggableScrollableSheet,
                                controller: txtConQuotation,
                                enabled: true,
                                readOnly: true,
                                name: 'quotation',
                                style: const TextStyle(
                                    color: AppColors.oonaPurple),
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.receipt,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Quotation No',
                                  labelText: 'Quotation No',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FormBuilderDateTimePicker(
                              name: 'date',
                              firstDate: DateTime.now(),
                              style:
                                  const TextStyle(color: AppColors.oonaPurple),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              //initialValue: DateTime.now(),
                              inputType: InputType.date,
                              decoration: const InputDecoration(
                                icon: FaIcon(
                                  Icons.calendar_today,
                                  color: AppColors.oonaPurple,
                                ),
                                border: InputBorder.none,
                                labelText: 'Survey Date',
                                hintStyle:
                                    TextStyle(color: AppColors.oonaPurple),
                                labelStyle:
                                    TextStyle(color: AppColors.oonaPurple),
                              ),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Kolom ini harus terisi'),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderDropdown<String>(
                                style: TextStyle(
                                  color: AppColors.oonaPurple,
                                  fontSize: 8.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                dropdownColor: AppColors.grey,
                                iconEnabledColor: AppColors.oonaPurple,
                                // autovalidate: true,
                                name: 'surveyZone',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.share_location,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Survey Zone',
                                  labelText: 'Survey Zone',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                // initialValue: 'Male',
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
                                items: zone
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
                          color: AppColors.grey30,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FormBuilderTextField(
                              onTap: () {
                                if (!kIsWeb) {
                                  initRenderer();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlacePicker(
                                          resizeToAvoidBottomInset: false,
                                          // only works in page mode, less flickery
                                          apiKey: Platform.isAndroid
                                              ? "AIzaSyA2PObNCiBHb5k-DU3HV-ivGId1mPnCP4A"
                                              : "AIzaSyA2PObNCiBHb5k-DU3HV-ivGId1mPnCP4A",
                                          hintText: "Find a place ...",
                                          searchingText: "Please wait ...",
                                          selectText: "Select place",
                                          outsideOfPickAreaText:
                                              "Place not in area",
                                          initialPosition:
                                              RequestReSurvey.kInitialPosition,
                                          useCurrentLocation: true,
                                          selectInitialPosition: false,
                                          usePinPointingSearch: true,
                                          usePlaceDetailSearch: true,
                                          zoomGesturesEnabled: true,
                                          enableMyLocationButton: false,
                                          enableMapTypeButton: true,
                                          forceAndroidLocationManager:
                                              Platform.isAndroid ? true : false,
                                          onMapCreated: (GoogleMapController
                                              controller) async {
                                            mapController = controller;
                                            Position position = await Geolocator
                                                .getCurrentPosition(
                                                    desiredAccuracy:
                                                        LocationAccuracy.high);
                                            controller.animateCamera(
                                                CameraUpdate.newLatLngZoom(
                                                    LatLng(position.latitude,
                                                        position.longitude),
                                                    13));
                                          },
                                          onPlacePicked: (PickResult result) {
                                            _onMapPicked(
                                                "${result.formattedAddress}",
                                                result.geometry!.location.lng,
                                                result.geometry!.location.lat);
                                            Navigator.of(context).pop();
                                          },
                                          onMapTypeChanged:
                                              (MapType mapType) {},
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Stack(
                                          children: [
                                            MapPicker(
                                              // kasih icon
                                              iconWidget: const Icon(
                                                Icons.pin_drop,
                                                color: AppColors.oonaPurple,
                                              ),
                                              //disini controller
                                              mapPickerController:
                                                  mapPickerController,
                                              child: GoogleMap(
                                                myLocationEnabled: true,
                                                zoomControlsEnabled: false,
                                                // ini hide loc
                                                myLocationButtonEnabled: false,
                                                mapType: MapType.normal,
                                                //  camera position
                                                initialCameraPosition:
                                                    cameraPosition,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) {
                                                  _controller
                                                      .complete(controller);
                                                },
                                                onCameraMoveStarted: () {
                                                  // map moving di rekam
                                                  mapPickerController
                                                      .mapMoving!();
                                                  textController.text =
                                                      "checking ...";
                                                },
                                                onCameraMove: (cameraPosition) {
                                                  this.cameraPosition =
                                                      cameraPosition;
                                                },
                                                onCameraIdle: () async {
                                                  // map berhenti moving
                                                  mapPickerController
                                                      .mapFinishedMoving!();
                                                  //get address pake geocoding
                                                  GeoData data = await Geocoder2
                                                      .getDataFromCoordinates(
                                                          latitude:
                                                              cameraPosition
                                                                  .target
                                                                  .latitude,
                                                          longitude:
                                                              cameraPosition
                                                                  .target
                                                                  .longitude,
                                                          googleMapApiKey:
                                                              "AIzaSyA2PObNCiBHb5k-DU3HV-ivGId1mPnCP4A");

                                                  // update ui
                                                  textController.text =
                                                      data.address;
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 24,
                                              left: 24,
                                              right: 24,
                                              child: SizedBox(
                                                height: 50,
                                                child: TextButton(
                                                  onPressed: () {
                                                    debugPrint(
                                                        "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                                                    debugPrint(
                                                        "Address: ${textController.text}");
                                                    _onMapPicked(
                                                        textController.text,
                                                        cameraPosition
                                                            .target.longitude,
                                                        cameraPosition
                                                            .target.latitude);
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                      AppColors.oonaPurple,
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 19,
                                                      // height: 19/19,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              style:
                                  const TextStyle(color: AppColors.oonaPurple),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: txtConAddress,
                              enabled: true,
                              readOnly: true,
                              name: 'address',
                              decoration: const InputDecoration(
                                icon: FaIcon(
                                  Icons.location_on,
                                  color: AppColors.oonaPurple,
                                ),
                                border: InputBorder.none,
                                hintText: 'Survey Location',
                                labelText: 'Survey Location',
                                hintStyle:
                                    TextStyle(color: AppColors.oonaPurple),
                                labelStyle:
                                    TextStyle(color: AppColors.oonaPurple),
                              ),
                              validator: FormBuilderValidators.required(
                                  errorText: 'Kolom ini harus terisi'),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(
                                    color: AppColors.oonaPurple),
                                //controller: txtConHospital,
                                enabled: true,
                                name: 'addressDetail',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.not_listed_location,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Address Detail',
                                  labelText: 'Address Detail',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(
                                    color: AppColors.oonaPurple),
                                //controller: txtConHospital,
                                enabled: true,
                                name: 'pic',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.person,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'PIC Survey',
                                  labelText: 'PIC Survey',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.grey30,
                          child: InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderDropdown<String>(
                                style: TextStyle(
                                  color: AppColors.oonaPurple,
                                  fontSize: 8.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                dropdownColor: AppColors.grey,
                                iconEnabledColor: AppColors.oonaPurple,
                                // autovalidate: true,
                                name: 'picRelation',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.handshake,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Relasi PIC dengan tertanggung',
                                  labelText: 'Relasi PIC dengan tertanggung',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                // initialValue: 'Male',
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
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
                          color: AppColors.grey30,
                          child: InkWell(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormBuilderTextField(
                                style: const TextStyle(
                                    color: AppColors.oonaPurple),
                                keyboardType: TextInputType.phone,
                                //controller: txtConHospital,
                                enabled: true,
                                name: 'mobile',
                                decoration: const InputDecoration(
                                  icon: FaIcon(
                                    Icons.phone,
                                    color: AppColors.oonaPurple,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'PIC Mobile Number',
                                  labelText: 'PIC Mobile Number',
                                  hintStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                  labelStyle:
                                      TextStyle(color: AppColors.oonaPurple),
                                ),
                                validator: FormBuilderValidators.required(
                                    errorText: 'Kolom ini harus terisi'),
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
                            //padding: AppDimension.mainPadding,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(0),
                                top: Radius.circular(0),
                              ),
                            ),
                            child: ListView(
                              controller: s,
                              children: [
                                ListTile(
                                  title: TextField(
                                    textInputAction: TextInputAction.search,
                                    controller: textEditingController,
                                    decoration: const InputDecoration(
                                        hintText: 'Search'),
                                    onSubmitted: _onSearchTextChanged,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
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
      survey.surveyType = "12";
      survey.surveyStatus = "O";
      survey.assignStatus = "05";
      survey.pICSurvey = _formKey.currentState?.value['pic'];
      survey.pICPhone = _formKey.currentState?.value['mobile'];
      survey.surveyDate = _formKey.currentState?.value['date'].toString();
      survey.surveyAddress = _formKey.currentState?.value['address'];

      var chekInResponse = await survey.SubmitRequest();
      if (chekInResponse['success'] == true) {
        final result = await showOkAlertDialog(
          context: context,
          title: 'Survey Request Saved',
          message: 'Survey request successfully saved',
          builder: (context, child) => Theme(
            data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                style:
                    TextButton.styleFrom(foregroundColor: AppColors.oonaPurple),
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
        showOkAlertDialog(
            context: context,
            title: 'claimFailed'.tr,
            message: chekInResponse['message'].toString().tr);
      }
    } else {}
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

  void _closeIcon() {
    if (isExpanded) {
      _toggleDraggableScrollableSheet();
    } else {
      Get.back();
    }
  }

  Future<void> _onSearchTextChanged(String text) async {
    Quotation quotation = Quotation();
    providerList.clear();
    Map<String, dynamic> result = await quotation.GetQuotationR(text);
    List<dynamic> data = result['data'];
    for (var element in data) {
      ListTile provider = ListTile(
        title: Text(
          element['QuotationNo'].toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(element['TOC']),
        //trailing: FaIcon(FontAwesomeIcons.mapPin),
        onTap: () async {
          if (element['PolicyType'].toString().contains("04")) {
            survey.aNO = element['ANO'].toString();
            survey.cNO = element['CNO'].toString();
            survey.quotationNo = element['QuotationNo'].toString();
            survey.tOC = element['TOC'].toString();
            survey.policyType = element['PolicyType'].toString();
            survey.branch = element['Branch'].toString();
            _toggleDraggableScrollableSheet();
            Get.to(RequestSurveyFleet(), arguments: survey);
          } else {
            survey.aNO = element['ANO'].toString();
            survey.cNO = element['CNO'].toString();
            survey.quotationNo = element['QuotationNo'].toString();
            survey.tOC = element['TOC'].toString();
            survey.policyType = element['PolicyType'].toString();
            survey.branch = element['Branch'].toString();
            _toggleDraggableScrollableSheet();
            txtConQuotation.text = element['QuotationNo'].toString();
          }
        },
      );

      setState(() {
        providerList.add(provider);
      });
    }
  }

  Future<void> _onMapPicked(String text, double long, double lat) async {
    txtConAddress.text = text;
    survey.surveyLongitude = long.toString();
    survey.surveyLatitude = lat.toString();
  }

  Future<void> GetGenTab() async {
    zone = await GenTab().GetZone();
    relation = await GenTab().GetRelation();
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
