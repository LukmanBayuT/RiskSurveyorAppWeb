import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/utils/app_colors.dart';
import '../../model/pdf.dart';
import '../../model/survey.dart';
import '../../model/survey_result.dart';
import '../../widget/custom_appbar.dart';
import 'home_svy.dart';

class ScrollTest extends StatefulWidget {
  const ScrollTest({super.key});

  @override
  State<ScrollTest> createState() => _ScrollTestState();
}

HandSignatureControl control = HandSignatureControl(
  threshold: 0.01,
  smoothRatio: 0.65,
  velocityRange: 2.0,
);

ValueNotifier<String?> svg = ValueNotifier<String?>(null);

ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);

ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);

class _ScrollTestState extends State<ScrollTest> {
  final control = HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  Survey survey = Survey();
  bool scrollEnabled = false;

  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.orange,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        //visible: !isExpanded,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.oonaPurple,
          label: const Text('Save'),
          icon: const FaIcon(Icons.save),
          onPressed: () async {
            save();
          },
        ),
      ),
      appBar: const CustomAppBar(
        title: 'SIGN FORM',
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            constraints: const BoxConstraints.expand(),
                            color: Colors.white,
                            child: HandSignature(
                              control: control,
                              color: AppColors.oonaPurple,
                              type: SignatureDrawType.shape,
                              onPointerUp: () async {
                                svg.value = control.toSvg(
                                  color: Colors.blueGrey,
                                  type: SignatureDrawType.shape,
                                  fit: true,
                                );

                                rawImage.value = await control.toImage(
                                  color: Colors.blueAccent,
                                  background: Colors.greenAccent,
                                  fit: false,
                                );

                                rawImageFit.value = await control.toImage(
                                  color: AppColors.oonaPurple,
                                  background: Colors.greenAccent,
                                  fit: true,
                                );
                              },
                            ),
                          ),
                          CustomPaint(
                            painter: DebugSignaturePainterCP(
                              control: control,
                              cp: false,
                              cpStart: false,
                              cpEnd: false,
                              color: AppColors.oonaPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () {
                        control.clear();
                        svg.value = null;
                        rawImage.value = null;
                        rawImageFit.value = null;
                      },
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          color: AppColors.oonaPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> save() async{
      survey.surveyStatus = surveyResult.pendingFlag == "0" ? 'A' : 'P';
      survey.assignStatus = data['AssignStatus'];
      survey.aNO = data['Ano'].toString();
      survey.cNO = data['CNO'].toString();
      final svg = control.toSvg();
      await pdf().generateFinalDocument(data, surveyResult, svg!);
      String directory = (await getApplicationDocumentsDirectory()).path;
      var targetPath = "$directory/${data['QuotationNo']}";
      var targetFileName = "SurveyReport";
      File file = File("$targetPath/$targetFileName.pdf");
      Uint8List bytes = file.readAsBytesSync();
      String base64Image = base64Encode(bytes);
      survey.surveyReport = base64Image;
      survey.autoReleaseF = surveyResult.autoreleaseF;

      showLoaderDialog(context);
      var checkInResponse = await survey.UpdateSurveyStatus();
      if (checkInResponse['success'] == true) {
        Navigator.pop(context);
        final result = await showOkAlertDialog(
          barrierDismissible: false,
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
        Navigator.pop(context);
        //Navigator.pop(context);
        showOkAlertDialog(context: context, title: 'claimFailed'.tr, message: checkInResponse['message'].toString().tr);
      }
  }

  showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: LoadingIndicator(text: "Saving Survey"),
            ));
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_getLoadingIndicator(), _getHeading(context), _getText(displayedText)]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(child: CircularProgressIndicator(strokeWidth: 3), width: 32, height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          "Mohon Tunggu",
          style: TextStyle(color: Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.black, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}


