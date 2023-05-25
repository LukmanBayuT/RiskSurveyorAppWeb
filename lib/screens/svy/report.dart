import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import 'package:http/http.dart' as http;

import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';
class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _reportState();
}

class _reportState extends State<Report> {
  String generatedPdfFilePath = "";
  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';
  @override
  void initState() {
    super.initState();
    //generateExampleDocument();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFAB(
          nextBtn: true,
          onBack: () {
            Get.back();
          },
          onNext: () {
            //Get.to(const Report(), arguments: data);
          },
        ),
        appBar: const CustomAppBar(
          title: 'SURVEY FORM',
        ),
        body: Column(
          children: const [
            Expanded(
              child: PdfView(path: "/data/user/0/id.myoona.risksurveyorapp/app_flutter/example-pdf.pdf"),
            ),
          ],
        ),
      ),
    );
  }
}
