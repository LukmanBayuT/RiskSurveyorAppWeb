import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/screens/svy/survey_tw_lh.dart';
import 'package:risk_surveyor_app/utils/app_dimension.dart';
import 'package:risk_surveyor_app/widget/custom_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../model/survey_result.dart';
import '../../model/util.dart';
import '../../utils/app_colors.dart';
import '../../widget/custom_fab.dart';

class SurveyTwExtRr extends StatefulWidget {
  const SurveyTwExtRr({Key? key}) : super(key: key);

  @override
  State<SurveyTwExtRr> createState() => _SurveyTwExtRrState();
}

class _SurveyTwExtRrState extends State<SurveyTwExtRr> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  Future<void> GetData() async {
    String directory = (await getApplicationDocumentsDirectory()).path;
    List filelist = Directory("$directory/${data['QuotationNo']}/").listSync();
    debugPrint(filelist.toString());
    imageFileList!.clear();
    for (File element in filelist) {
      if (element.toString().contains("_ext_rr_")) {
        var filepath = element.toString().split('_');
        var id = filepath[filepath.length - 1].split('.')[0];
        debugPrint(id);
        debugPrint(element.toString());
        imageFileList?.add(XFile(element.path));
      }
    }
    surveyResult.loadChecklistFromJsonFile(data['QuotationNo'].toString());
    debugPrint("OK2");
    debugPrint(imageFileList.toString());
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    bool isAllow = false;
    selectedImages.forEach((selectedImage) async {
      if (await Util().isImageAllowed(selectedImage)) {
        final Directory appPath = await getApplicationDocumentsDirectory();
        final String newPath = '${appPath.path}/${data['QuotationNo']}';
        final String fileName = '${data['QuotationNo']}_ext_rr_${imageFileList?.length}.jpg';
        debugPrint(selectedImage.path);
        debugPrint('$newPath/$fileName');
        await selectedImage.saveTo('$newPath/$fileName');

        debugPrint(imageFileList.toString());
        debugPrint("OK");
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
        final String fileName = '${data['QuotationNo']}_ext_rr_${imageFileList?.length}.jpg';
        if (!File(newPath).existsSync()) {
          File(newPath).create(recursive: true);
        }
        debugPrint(selectedImage.path);
        debugPrint('$newPath/$fileName');
        await selectedImage.saveTo('$newPath/$fileName');
        imageFileList!.add(selectedImage);
      }
    }
    setState(() {});
  }


  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];

  Widget _previewImages() {
    if (imageFileList!.isNotEmpty) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: GridView.builder(
            itemCount: imageFileList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
              'Berdiri di belakang motor sperti di gambar.'
                  '\n'
                  'Klik ikon kamera pada perangkat anda.'
                  '\n'
                  'Ambil gambar sejelas mungkin.'
                  '\n'
                  '\n'
                  'atau'
                  '\n'
                  '\n'
                  'Pilih gambar dari galery'
                  '\n',
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/tw-rr.png', height: 35.h),
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
                            "Bagian Belakang",
                            style: TextStyle(fontSize: AppDimension.fontSizeSmall, fontWeight: FontWeight.bold, color: AppColors.oonaPurple),
                          ),
                        ),
                        _previewImages()
                      ],
                    ),
                  ),
                ),
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
                Get.to(const SurveyTwExtLh(), arguments: [data, surveyResult]);
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
}
