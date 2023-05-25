import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SurveyResult {
  String? actualPic = "";
  String? actualPicRelation = "";
  Map<String, dynamic>? checklist = {};
  String? recommendation = "";
  String? response = "";
  String? redFlag = "0";
  String? pendingFlag = "0";
  String? autoreleaseF = "0";

  SurveyResult();

  SurveyResult.fromJson(Map<String, dynamic> json) {
    actualPic = json['actualPic'];
    actualPicRelation = json['actualPicRelation'];
    checklist = json['checklist'];
    response = json['response'];
    recommendation = json['recomendation'];
    redFlag = json['redFlag'];
    pendingFlag = json['pendingFlag'];
    autoreleaseF = json['AutoreleasF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualPic'] = this.actualPic;
    data['actualPicRelation'] = this.actualPicRelation;
    data['checklist'] = this.checklist;
    data['response'] = this.response;
    data['recommendation'] = this.recommendation;
    data['redFlag'] = this.redFlag;
    data['pendingFlag'] = this.pendingFlag;
    data['autoreleaseF'] = this.autoreleaseF;
    return data;
  }

  saveChecklistToJsonFile(Map<String, dynamic> data, String quotationNO) async {
    final Directory appPath = await getApplicationDocumentsDirectory();
    final File file = File('${appPath.path}/$quotationNO/checklist.json');
    await file.writeAsString(json.encode(data));
  }

  loadChecklistFromJsonFile(String quotationNO) async {
    final Directory appPath = await getApplicationDocumentsDirectory();
    final File file = File('${appPath.path}/$quotationNO/checklist.json');
    checklist = await json.decode(await file.readAsString());
    debugPrint(checklist.toString());
  }

  checkAutoRelease(String exAutoReleaseF) {
    bool rps = false;
    bool flood = false;
    int penyok = 0;

    if (exAutoReleaseF == "true") {
      checklist!.forEach((key, value) {
        if (key != "Roof/Kap Atas Luar" && key != "Ruang Mesin" && value.toString().contains("Retak/Pecah/Sobek") ) {
          rps = true;
        }

        if (key == "Apakah unit kendaraan terdapat indikasi bekas terdampak banjir?" && value.toString().contains("Ya")) {
          flood = true;
        }

        if (key != "Roof/Kap Atas Luar" && key != "Ruang Mesin" && value.toString().contains("Penyok")) {
          penyok += 1;
        }
      });
      if (!rps && !flood && penyok < 3 && exAutoReleaseF == "true") {
        autoreleaseF = "true";
      } else {
        autoreleaseF = "false";
      }
    }
    autoreleaseF = "false";
  }
}
