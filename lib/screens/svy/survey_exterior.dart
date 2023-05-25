import 'dart:convert';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:risk_surveyor_app/screens/svy/survey_interiror.dart';


class SurveyExterior extends StatefulWidget {
  const SurveyExterior({Key? key}) : super(key: key);
  @override
  SurveyExteriorState createState() {
    return SurveyExteriorState();
  }
}

class SurveyExteriorState extends State<SurveyExterior> {
  final ExtListController extListController = Get.put(ExtListController());

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

  Future<OkCancelResult> showSuccesAlertDialog({
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
  Map<int, dynamic> file = {};
  Map<int, String> id = {};
  String status = '';
  String? base64Image;
  File? tmpFile;
  String errMessage = 'Error Uploading Image';

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

  // upload(String fileName, int index, BuildContext context) async {
  //   // http.post(Uri.https('www.abdaonline.com', '/ahmobileapi/api/Claim/UploadDocument'), body: {
  //   //   "file": base64Encode(File(fileName).readAsBytesSync()),
  //   //   "data": "{ 'claimNo': '090100822002706', 'docID': 'OP001', 'docDesc': 'OP001', 'Planguage': 'E', 'Validatestr': '@BD461948489!!#148sipl'}",
  //   // }).then((result) {
  //   //   setStatus(result.statusCode == 200 ? result.body : errMessage);
  //   //   Logger().d(jsonDecode(utf8.decode(result.bodyBytes)));
  //   // }).catchError((error) {
  //   //   showOkAlertDialog(
  //   //       context: context,
  //   //       title: 'uploadError'.tr,
  //   //       message: 'tryAgain'.tr);
  //   // });
  //   File imageFile = File(fileName);
  //   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();
  //
  //   var uri = Uri.https('www.abdaonline.com', '/ahmobileapi/api/Claim/UploadDocument');
  //
  //   var request = new http.MultipartRequest("POST", uri);
  //   var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));
  //   //contentType: new MediaType('images', 'png'));
  //
  //   request.files.add(multipartFile);
  //   request.fields['data'] =
  //   "{ 'claimNo': '${_claim.claimNo}', 'docID': '${id[index]}', 'docDesc': '${id[index]}', 'Planguage': 'E', 'Validatestr': '@BD461948489!!#148sipl'}";
  //   var response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     response.stream.transform(utf8.decoder).listen((value) {
  //       var result = jsonDecode(value) as Map;
  //       if (result['Success'] == true) {
  //         showOkAlertDialog(
  //             context: context,
  //             title: 'uploadSuccess'.tr,
  //             message: file.length.toString() + ' of '.tr + docListController.count.toString());
  //       } else {
  //         showOkAlertDialog(context: context, title: 'uploadFailed'.tr, message: result['pInfo']);
  //         setState(() {
  //           file.remove(index);
  //         });
  //       }
  //     });
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            label: Text('next'.tr),
            icon: const Icon(Icons.navigate_next),
            onPressed: () async {
              next(context);
            }),
        appBar: AppBar(
          title: Text("Upload Document".tr),
          leading: GestureDetector(
            onTap: () {},
            child: const Text(''),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: extListController.obx(
                    (data) => Center(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.grey[100],
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                data[index]['name'].toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: !file.containsKey(index)
                                  ? Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      //color: Colors.greenAccent,
                                      onPressed: () {
                                        id[index] = data[index]['id'].toString();
                                        _getFromGallery(index, context);
                                      },
                                      child: const Text("PICK FROM STORAGE"),
                                    ),
                                    Container(
                                      width: 40.0,
                                    ),
                                    ElevatedButton(
                                      //color: Colors.lightGreenAccent,
                                      onPressed: () {
                                        id[index] = data[index]['id'].toString();
                                        _getFromCamera(index, context);
                                      },
                                      child: const Text("PICK FROM CAMERA"),
                                    )
                                  ],
                                ),
                              )
                                  : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    file[index] = 'null';
                                  });
                                },
                                child: Container(
                                  child: file[index] != "null"
                                      ? lookupMimeType(file[index]!.path)!
                                      .split('/')[0]
                                      .toString() ==
                                      'images'
                                      ? Image.file(
                                    file[index]!,
                                    fit: BoxFit.cover,
                                  )
                                      : Column(
                                    children: [
                                      const Icon(Icons
                                          .insert_drive_file),
                                      Text(p.basename(
                                          file[1]!.path))
                                    ],
                                  )
                                      : Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        ElevatedButton(
                                          //color: Colors.greenAccent,
                                          onPressed: () {
                                            id[index] = data[index]['id'].toString();
                                            _getFromGallery(
                                                index, context);
                                          },
                                          child: const Text(
                                              "PICK FROM STORAGE"),
                                        ),
                                        Container(
                                          width: 40.0,
                                        ),
                                        ElevatedButton(
                                          //color: Colors.lightGreenAccent,
                                          onPressed: () {
                                            id[index] = data[index]['id'].toString();
                                            _getFromCamera(
                                                index, context);
                                          },
                                          child: const Text(
                                              "PICK FROM CAMERA"),
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
        ));
  }

  Future<void> next(BuildContext context) async {
    //if (file.length > 0) {
    if (file.length == extListController.count && !file.containsValue("null")) {
      Get.to(const SurveyInterior());
    } else {
      final result = await showOkCancelAlertDialog(
          context: context,
          title: 'Are you sure to continue?'.tr,
          message: 'Incomplete Document'.tr,
          cancelLabel: 'Keep Uploading'.tr,
          okLabel: 'Yes'.tr,
          defaultType: OkCancelAlertDefaultType.cancel,
          barrierDismissible: false);
      if (result == OkCancelResult.ok) {
        Get.to(const SurveyInterior());
      }
    }
    // } else {
    //   final result = await showOkAlertDialog(
    //     context: context,
    //     title: 'noDocUploaded'.tr,
    //     message: 'uploadAtLeast'.tr,
    //     okLabel: 'yes'.tr,
    //   );
    // }
  }

  _getFromGallery(index, BuildContext context) async {
    final result = await showModalActionSheet<String>(
      context: context,
      title: 'storage'.tr,
      actions: [
        SheetAction(
          icon: Icons.photo,
          label: 'gallery'.tr,
          key: 'gallery',
        ),
        SheetAction(
          icon: Icons.folder,
          label: 'file'.tr,
          key: 'file',
          isDefaultAction: true,
        ),
      ],
    );

    if (result == 'gallery') {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        //upload(pickedFile.path, index, context);
        setState(() {
          file[index] = File(pickedFile.path);
        });
      }
    } else if (result == 'file') {
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

      if (filePickerResult != null) {
        PlatformFile pickedFile = filePickerResult.files.first;
        String? jpegPath = '';

        jpegPath = pickedFile.path!;

        if (pickedFile.extension == 'HEIF' || pickedFile.extension == 'HEIC') {
          jpegPath = await HeicToJpg.convert(pickedFile.path!);
        }

        setState(() {
          file[index] = File(jpegPath!);
        });
      } else {
        // User canceled the picker
      }
    }
  }

  /// Get from Camera
  _getFromCamera(index, BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      //upload(pickedFile.path, index, context);
      setState(() {
        file[index] = File(pickedFile.path);
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
        {"id": 111, "name": "Body Kanan", "status" : "Assigned"},
        {"id": 111, "name": "Body Kiri", "status" : "Assigned"},
        {"id": 111, "name": "Body Depan", "status" : "Assigned"},
        {"id": 111, "name": "Body Belakang", "status" : "Assigned"},
        {"id": 111, "name": "Body Atas", "status" : "Assigned"},
        {"id": 111, "name": "Body Bawah", "status" : "Assigned"},
        {"id": 111, "name": "Ruang Kap Mesin dan Bagasi Mobil", "status" : "Assigned"},
        {"id": 111, "name": "Rumah – Rumah Lampu", "status" : "Assigned"},
        {"id": 111, "name": "Nomor Rangka (VIN)", "status" : "Assigned"},
        {"id": 111, "name": "Nomor Engine", "status" : "Assigned"},
        {"id": 111, "name": "Equipment Non-Standard Exterior Mobil", "status" : "Assigned"},
      ];
    } else {
      return Future.error("Error");
    }
  }
}

class ExtListController extends GetxController with StateMixin<List<dynamic>> {
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
    Get.lazyPut(() => ExtListController());
  }
}
