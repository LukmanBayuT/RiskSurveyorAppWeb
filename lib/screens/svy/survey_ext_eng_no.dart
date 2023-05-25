import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/screens/svy/survey_ext_eq.dart';
import 'package:sizer/sizer.dart';

import '../../model/survey_result.dart';
import '../../model/util.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class SurveyExtEngNo extends StatefulWidget {
  const SurveyExtEngNo({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SurveyExtEngNo> createState() => _SurveyExtEngNoState();
}

class _SurveyExtEngNoState extends State<SurveyExtEngNo> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];
  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];

  Future<void> GetData() async {
    String directory = (await getApplicationDocumentsDirectory()).path;
    List filelist = Directory("$directory/${data['QuotationNo']}/").listSync();
    imageFileList!.clear();
    for (File element in filelist) {
      if (element.toString().contains("_ext_eng_no_")) {
        var filepath = element.toString().split('_');
        var id = filepath[filepath.length - 1].split('.')[0];
        imageFileList?.add(XFile(element.path));
      }
    }
    surveyResult.loadChecklistFromJsonFile(data['QuotationNo'].toString());
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    bool isAllow = false;
    selectedImages.forEach((selectedImage) async {
      if (await Util().isImageAllowed(selectedImage)) {
        final Directory appPath = await getApplicationDocumentsDirectory();
        final String newPath = '${appPath.path}/${data['QuotationNo']}';
        final String fileName = '${data['QuotationNo']}_ext_eng_no_${imageFileList?.length}.jpg';
        await selectedImage.saveTo('$newPath/$fileName');
        setState(() {
          imageFileList!.add(selectedImage);
        });
      }
    });
  }

  void takePhoto() async {
    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      if (await Util().isImageAllowed(selectedImage)) {
        final Directory appPath = await getApplicationDocumentsDirectory();
        final String newPath = '${appPath.path}/${data['QuotationNo']}';
        final String fileName = '${data['QuotationNo']}_ext_eng_no_${imageFileList?.length}.jpg';
        if (!File(newPath).existsSync()) {
          File(newPath).create(recursive: true);
        }
        await selectedImage.saveTo('$newPath/$fileName');
        imageFileList!.add(selectedImage);
      }
    }
    setState(() {});
  }

  final _formKey = GlobalKey<FormBuilderState>();

  Widget _previewImages() {
    if (imageFileList!.isNotEmpty) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: GridView.builder(
            itemCount: imageFileList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  File(imageFileList![index].path).delete();
                  imageFileList!.removeAt(index);
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.all(0.25 * AppDimension.blockSizeHorizontal),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.5 * AppDimension.blockSizeHorizontal),
                    child: Image.file(
                      File(imageFileList![index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            Text(
              style: TextStyle(
                fontSize: AppDimension.fontSizeSmall,
                color: AppColors.oonaPurple,
              ),
              'Klik ikon kamera pada perangkat anda.'
                  '\n'
                  'Ambil gambar sejelas mungkin.'
                  '\n'
                  '\n'
                  'atau'
                  '\n'
                  '\n'
                  'Pilih gambar dari galery'
                  '\n'
                  '\n',
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/vin.png', height: 35.h),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "SURVEY FORM",
      ),
      body: Container(
        padding: AppDimension.mainPadding,
        child: FutureBuilder(
          future: GetData(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            return Column(
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.grey30,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Nomor Mesin",
                            style: TextStyle(
                              fontSize: AppDimension.fontSizeSmall,
                              fontWeight: FontWeight.bold,
                              color: AppColors.oonaPurple,
                            ),
                          ),
                        ),
                        _previewImages()
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: FormBuilder(
                //     key: _formKey,
                //     child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
                //       return SingleChildScrollView(
                //         child: Column(
                //           children: [
                //             Card(
                //               color: Colors.grey[400],
                //               child: Column(
                //                 children: [
                //                   ListTile(
                //                     title: Text(
                //                       "Survey Checklist",
                //                       style: TextStyle(
                //                          fontSize: AppDimension.fontSizeSmall,fontWeight: FontWeight.bold),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     }),
                //   ),
                // ),
              ],
            );
          }
        ),
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
              backgroundColor: AppColors.mediumTurquoise,
              onPressed: () {
                selectImages();
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.mediumTurquoise,
              onPressed: () {
                takePhoto();
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () {
                next();
                //Get.to(const SurveyExtEq(), arguments: data);
              },
              heroTag: 'next',
              tooltip: 'Next',
              child: const Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }

  next() async {
    //if (_formKey.currentState?.saveAndValidate() ?? false) {
    if (imageFileList!.isNotEmpty) {
      //surveyResult.checklist?.addAll(_formKey.currentState!.value);
      //surveyResult.saveChecklistToJsonFile(surveyResult.checklist!, data['QuotationNo'].toString());
      //surveyResult.loadChecklistFromJsonFile(data['QuotationNo']);
      Get.to(const SurveyExtEq(), arguments: [data, surveyResult]);
    } else {
      final result = await showOkAlertDialog(
        context: context,
        title: 'Tidak ada foto diambil',
        message: 'Anda diharuskan mengambil minimal 1 foto',
        builder: (context, child) =>
            Theme(
              data: ThemeData(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: AppColors.oonaPurple),
                ),
              ),
              child: child,
            ),
      );
    }
    // } else {
    //   debugPrint(_formKey.currentState?.value.toString());
    //   debugPrint('validation failed');
    // }
  }
}
