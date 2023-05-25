import 'dart:convert';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/model/survey_result.dart';
import 'package:risk_surveyor_app/screens/svy/survey_ext_fr.dart';
import 'package:risk_surveyor_app/screens/svy/survey_tw_fr.dart';
import 'package:risk_surveyor_app/widget/custom_fab.dart';

import '../../model/util.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';

class SurveyDocument extends StatefulWidget {
  const SurveyDocument({Key? key}) : super(key: key);

  @override
  SurveyDocumentState createState() {
    return SurveyDocumentState();
  }
}

class SurveyDocumentState extends State<SurveyDocument> {
  final DocListController docListController = Get.put(DocListController());

  Future<OkCancelResult> showOkAlertDialog({
    required BuildContext context,
    String? title,
    String? message,
    String? okLabel,
    bool barrierDismissible = true,
    AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
    bool useActionSheetForCupertino = false,
    bool useRootNavigator = true,
    VerticalDirection actionsOverflowDirection = VerticalDirection.up,
    bool fullyCapitalizedForMaterial = true,
    WillPopCallback? onWillPop,
  }) async {
    final result = await showAlertDialog<OkCancelResult>(
      context: context,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      style: alertStyle,
      useActionSheetForIOS: useActionSheetForCupertino,
      useRootNavigator: useRootNavigator,
      actionsOverflowDirection: actionsOverflowDirection,
      fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
      onWillPop: onWillPop,
      actions: [
        AlertDialogAction(
          label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
          key: OkCancelResult.ok,
        )
      ],
    );
    return result ?? OkCancelResult.cancel;
  }

  Future<OkCancelResult> showSuccessAlertDialog({
    required BuildContext context,
    String? title,
    String? message,
    String? okLabel,
    bool barrierDismissible = true,
    AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
    bool useActionSheetForCupertino = false,
    bool useRootNavigator = true,
    VerticalDirection actionsOverflowDirection = VerticalDirection.up,
    bool fullyCapitalizedForMaterial = true,
    WillPopCallback? onWillPop,
  }) async {
    final result = await showAlertDialog<OkCancelResult>(
      context: context,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      style: alertStyle,
      useActionSheetForIOS: useActionSheetForCupertino,
      useRootNavigator: useRootNavigator,
      actionsOverflowDirection: actionsOverflowDirection,
      fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
      onWillPop: onWillPop,
      actions: [
        AlertDialogAction(
          label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
          key: OkCancelResult.ok,
        ),
      ],
    );
    return result ?? OkCancelResult.cancel;
  }

  Future<XFile?> xFile = Future<XFile?>.delayed(
    const Duration(seconds: 2),
    () => null,
  );
  Map<String, dynamic> file = {};
  Map<int, String> id = {};
  String status = '';
  String? base64Image;
  File? tmpFile;
  String errMessage = 'Error Uploading Image';

  Future<void> GetData() async {
    String directory = (await getApplicationDocumentsDirectory()).path;
    List filelist = Directory("$directory/${data['QuotationNo']}/").listSync();
    debugPrint(filelist.toString());
    for (File element in filelist) {
      if (element.toString().contains("_doc_")) {
        var filepath = element.toString().split('_');
        var id = filepath[filepath.length - 1].split('.')[0];
        debugPrint(id);
        debugPrint(element.toString());
        file[id] = element;
      }
    }
    debugPrint("OK2");
    debugPrint(file.toString());
  }

  void chooseImage(int index) {
    final ImagePicker picker = ImagePicker();
    setState(() {
      xFile = picker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage(int index) {
    return FutureBuilder<XFile?>(
      future: xFile,
      builder: (BuildContext context, AsyncSnapshot<XFile?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && null != snapshot.data) {
          tmpFile = File(snapshot.data!.path);
          base64Image = base64Encode(tmpFile!.readAsBytesSync());
          return Image.file(
            tmpFile!,
            fit: BoxFit.fill,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFAB(
          nextBtn: true,
          onBack: () {
            Get.back();
          },
          onNext: () {
            // if(sIndex ==0) {
            //   Get.to(const SurveyExtFr());
            // } else{
            //   Get.to(const SurveyTwExtFr());
            // }
            next();
          },
        ),
        appBar: const CustomAppBar(
          title: 'UPLOAD DOCUMENT',
        ),
        body: Container(
          padding: AppDimension.mainPadding,
          child: FutureBuilder(
              future: GetData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Column(
                  children: [
                    Expanded(
                      child: docListController.obx(
                        (data) => Center(
                          child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: AppColors.grey30,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        data[index]['name'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.oonaPurple,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: !file.containsKey(data[index]['id'].toString())
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.oonaPurple),
                                                    onPressed: () {
                                                      id[index] = data[index]['id'].toString();
                                                      _getFromGallery(data[index]['id'].toString(), context);
                                                    },
                                                    child: const Text("Upload from Gallery"),
                                                  ),
                                                  Container(
                                                    width: 40.0,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.oonaPurple),
                                                    onPressed: () {
                                                      id[index] = data[index]['id'].toString();
                                                      _getFromCamera(data[index]['id'].toString(), context);
                                                    },
                                                    child: const Text("Take a Photo"),
                                                  )
                                                ],
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  file[data[index]['id']].delete();
                                                  file[data[index]['id']] = 'null';
                                                });
                                              },
                                              child: Container(
                                                child: file[data[index]['id'].toString()] != "null"
                                                    ? lookupMimeType(file[data[index]['id'].toString()]!.path)!.split('/')[0].toString() == 'image'
                                                        ? Image.file(
                                                            file[data[index]['id'].toString()]!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Column(
                                                            children: [
                                                              const Icon(Icons.insert_drive_file),
                                                              Text(p.basename(file[data[index]['id'].toString()]!.path))
                                                            ],
                                                          )
                                                    : Container(
                                                        alignment: Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            ElevatedButton(
                                                              //color: Colors.greenAccent,
                                                              onPressed: () {
                                                                id[index] = data[index]['id'].toString();
                                                                _getFromGallery(data[index]['id'].toString(), context);
                                                              },
                                                              child: const Text("Upload from Gallery"),
                                                            ),
                                                            Container(
                                                              width: 40.0,
                                                            ),
                                                            ElevatedButton(
                                                              //color: Colors.lightGreenAccent,
                                                              onPressed: () {
                                                                id[index] = data[index]['id'].toString();
                                                                _getFromCamera(data[index]['id'].toString(), context);
                                                              },
                                                              child: const Text("Take a Photo"),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }

  Future<void> next() async {
    //if (file.length > 0) {
    //debugPrint(file.toString());
    if (file.length == docListController.count && !file.containsValue("null")) {
      if(data['TOC'] == '0212' || data['TOC'] == '0214'){
        Get.to( SurveyExtFr(), arguments: [data, surveyResult]);
      } else{
        Get.to( SurveyTwExtFr(), arguments: [data, surveyResult]);
      }
    } else {
      surveyResult.pendingFlag = "1";
      final result = await showOkCancelAlertDialog(
        context: context,
        title: 'Are you sure to continue?'.tr,
        message: 'Incomplete Document'.tr,
        cancelLabel: 'Keep Uploading'.tr,
        okLabel: 'Yes'.tr,
        defaultType: OkCancelAlertDefaultType.cancel,
        barrierDismissible: false,
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
        if(data['TOC'] == '0212' || data['TOC'] == '0214'){
          Get.to( SurveyExtFr(), arguments: [data, surveyResult]);
        } else{
          Get.to( SurveyTwExtFr(), arguments: [data, surveyResult]);
        }
      }
    }
  }

  final ImagePicker imagePicker = ImagePicker();

  _getFromGallery(index, BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null && await Util().isImageAllowed(pickedFile)) {
      final Directory appPath = await getApplicationDocumentsDirectory();
      final String newPath = '${appPath.path}/${data['QuotationNo']}';
      final String fileName = '${data['QuotationNo']}_doc_${index}.jpg';
      if (!File(newPath).existsSync()) {
        File(newPath).create(recursive: true);
      }
      debugPrint(pickedFile.path);
      debugPrint('$newPath/$fileName');
      await pickedFile.saveTo('$newPath/$fileName');
      setState(() {
        file[index] = File('$newPath/$fileName');
      });
    }
  }

  /// Get from Camera
  _getFromCamera(index, BuildContext context) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null && await Util().isImageAllowed(pickedFile)) {
      final Directory appPath = await getApplicationDocumentsDirectory();
      final String newPath = '${appPath.path}/${data['QuotationNo']}';
      final String fileName = '${data['QuotationNo']}_doc_${index}.jpg';
      if (!File(newPath).existsSync()) {
        File(newPath).create(recursive: true);
      }
      debugPrint(pickedFile.path);
      debugPrint('$newPath/$fileName');
      await pickedFile.saveTo('$newPath/$fileName');
      setState(() {
        file[index] = File('$newPath/$fileName');
      });
    }
  }
}

class Provider extends GetConnect {
  Future<List<dynamic>> getClaimDocList() async {
    //Claim _claim = Get.arguments;
    //var loginResponse = await _claim.getClaimDocList();
    if (true == true) {
      return [
        {"id": "KTP", "name": "KTP", "status": "Assigned"},
        {"id": "STNK1", "name": "STNK Bagian Depan", "status": "Assigned"},
        {"id": "STNK2", "name": "STNK Bagian Belakang", "status": "Assigned"},
        {"id": "SIM", "name": "SIM", "status": "Assigned"},
      ];
    } else {
      return Future.error("Error");
    }
  }
}

class DocListController extends GetxController with StateMixin<List<dynamic>> {
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    Provider().getClaimDocList().then((value) {
      count = value.length;
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DocListController());
  }
}
