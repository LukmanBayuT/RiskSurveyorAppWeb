import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_surveyor_app/model/survey_result.dart';

class pdf{

  Future<void> generateFinalDocument(var data, SurveyResult surveyResult, String sign) async {

    String directory = (await getApplicationDocumentsDirectory()).path;
    String image = "";
    List filelist = Directory("$directory/${data['QuotationNo']}/").listSync();
    for (File element in filelist) {
      debugPrint(element.path);
      if(!element.path.contains("pdf") && !element.path.contains("json")){
        image += '<img class="img" src="file://${element.path}"alt="web-img"><br>';
        debugPrint(image);
      }
    }

    var htmlContent = """
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="id" lang="id">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>file_1682625288353</title>
    <meta name="author" content="RISSA" />
    <style type="text/css">
      * {
        margin: 0;
        padding: 0;
        text-indent: 0;
      }

      h1 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: italic;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      p {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: bold;
        text-decoration: none;
        font-size: 14pt;
        margin: 0pt;
      }

      .s1 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: normal;
        text-decoration: none;
        font-size: 12pt;
      }

      .s2 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: italic;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      .s3 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      .s4 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: normal;
        text-decoration: none;
        font-size: 12pt;
      }

      table,
      tbody,
      td,
      tr {
        vertical-align: top;
        overflow: visible;
      }
      
      img {
        display: inline-block;
        width: 100%; // Show 4 images in a row normally
        height: auto;
      }
    </style>
  </head>
  <body>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p style="padding-top: 2pt;padding-left: 51pt;text-indent: 0pt;text-align: left;">LAPORAN SURVEY PENUTUPAN KENDARAAN BERMOTOR</p>
    <p style="padding-left: 7pt;text-indent: 0pt;text-align: left;" />
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <table style="border-collapse:collapse;margin-left:5.869pt" cellspacing="0">
      <tr style="height:20pt">
        <td style=";border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nama Tertanggung</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['AName']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Alamat Tertanggung</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['Address_1']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Lokasi Survey</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['SurveyAddress']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Tanggal Survey :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['SurveyDate']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Merk</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC1']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Model / Type</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC2']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Polisi</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC4']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Rangka</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC6']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Tahun</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC9']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Mesin</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC5']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Warna</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC10']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Penggunaan</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC7']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Rincian Perlengkapan non standard</p>
        </td>
      </tr>
      <tr style="height:47pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['Equipment']}</p>
        </td>
      </tr>
      <tr style="height:61pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Rekomendasi Surveyor :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s3" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.recommendation.toString()}</p>
        </td>
      </tr>
      <tr style="height:61pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Respon PIC :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s3" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.response.toString()}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Checklist</p>
        </td>
      </tr>
      <tr style="height:47pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.checklist.toString().replaceAll("],", "<br><br>").replaceAll("[", "<br>-").replaceAll("{", "").replaceAll("}", "")}</p>
        </td>
      </tr>
    </table>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p class="s4" style="padding-top: 4pt;padding-left: 7pt;text-indent: 0pt;text-align: left;">PIC Survey</p>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
      $sign
      <br />
    </p>
    <p class="s4" style="padding-left: 7pt;text-indent: 0pt;text-align: left;">${surveyResult.actualPic}</p>
    <h1 style="padding-left: 7pt;text-indent: 0pt;text-align: left;">Catatan : Foto kendaraan dan esek-esek no mesin &amp; rangka terlampir</h1>
    $image
  </body>
</html>
    """;

    var targetPath = "$directory/${data['QuotationNo']}/";
    var targetFileName = "SurveyReport";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(htmlContent, targetPath, targetFileName);
    var generatedPdfFilePath = generatedPdfFile.path;

  }

  Future<void> generateExampleDocument(var data, SurveyResult surveyResult) async {

    String directory = (await getApplicationDocumentsDirectory()).path;
    String image = "";
    List filelist = Directory("$directory/${data['QuotationNo']}/").listSync();
    for (File element in filelist) {
      debugPrint(element.path);
      if(!element.path.contains("pdf") && !element.path.contains("json")){
        image += '<img class="img" src="file://${element.path}"alt="web-img"><br>';
        debugPrint(image);
      }
    }

    var htmlContent = """
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="id" lang="id">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>file_1682625288353</title>
    <meta name="author" content="RISSA" />
    <style type="text/css">
      * {
        margin: 0;
        padding: 0;
        text-indent: 0;
      }

      h1 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: italic;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      p {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: bold;
        text-decoration: none;
        font-size: 14pt;
        margin: 0pt;
      }

      .s1 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: normal;
        text-decoration: none;
        font-size: 12pt;
      }

      .s2 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: italic;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      .s3 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: bold;
        text-decoration: none;
        font-size: 12pt;
      }

      .s4 {
        color: black;
        font-family: "Times New Roman", serif;
        font-style: normal;
        font-weight: normal;
        text-decoration: none;
        font-size: 12pt;
      }

      table,
      tbody,
      td,
      tr {
        vertical-align: top;
        overflow: visible;
      }
      
      img {
        display: inline-block;
        width: 100%; // Show 4 images in a row normally
        height: auto;
      }
    </style>
  </head>
  <body>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p style="padding-top: 2pt;padding-left: 51pt;text-indent: 0pt;text-align: left;">LAPORAN SURVEY PENUTUPAN KENDARAAN BERMOTOR</p>
    <p style="padding-left: 7pt;text-indent: 0pt;text-align: left;" />
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <table style="border-collapse:collapse;margin-left:5.869pt" cellspacing="0">
      <tr style="height:20pt">
        <td style=";border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nama Tertanggung</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['AName']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Alamat Tertanggung</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['Address_1']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Lokasi Survey</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-right: 4pt;text-indent: 0pt;text-align: right;">:</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['SurveyAddress']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Tanggal Survey :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['SurveyDate']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Merk</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC1']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Model / Type</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC2']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Polisi</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC4']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Rangka</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC6']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Tahun</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC9']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Nomor Mesin</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC5']}</p>
        </td>
      </tr>
      <tr style="height:19pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Warna</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC10']}</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Penggunaan</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s1" style="padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;">: ${data['VALUEDESC7']}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Rincian Perlengkapan non standard</p>
        </td>
      </tr>
      <tr style="height:47pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${data['Equipment']}</p>
        </td>
      </tr>
      <tr style="height:61pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Rekomendasi Surveyor :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s3" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.recommendation.toString()}</p>
        </td>
      </tr>
      <tr style="height:61pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="2">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Respon PIC :</p>
        </td>
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="3">
          <p class="s3" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.response.toString()}</p>
        </td>
      </tr>
      <tr style="height:20pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s2" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">Checklist</p>
        </td>
      </tr>
      <tr style="height:47pt">
        <td style="border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt" colspan="5">
          <p class="s1" style="padding-top: 2pt;padding-left: 2pt;text-indent: 0pt;text-align: left;">${surveyResult.checklist.toString().replaceAll("],", "<br><br>").replaceAll("[", "<br>-").replaceAll("{", "").replaceAll("}", "")}</p>
        </td>
      </tr>
    </table>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p class="s4" style="padding-top: 4pt;padding-left: 7pt;text-indent: 0pt;text-align: left;">PIC Survey</p>
    <p style="text-indent: 0pt;text-align: left;">
      <br />
    </p>
    <p class="s4" style="padding-left: 7pt;text-indent: 0pt;text-align: left;">${surveyResult.actualPic}</p>
    <h1 style="padding-left: 7pt;text-indent: 0pt;text-align: left;">Catatan : Foto kendaraan dan esek-esek no mesin &amp; rangka terlampir</h1>
    $image
  </body>
</html>
    """;

    var targetPath = "$directory/${data['QuotationNo']}/";
    var targetFileName = "SurveyReport";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(htmlContent, targetPath, targetFileName);
    var generatedPdfFilePath = generatedPdfFile.path;

  }
}