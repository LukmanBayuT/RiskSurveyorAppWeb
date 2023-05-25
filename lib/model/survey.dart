import 'package:risk_surveyor_app/model/http_client.dart';

class Survey {
  String? aNO = "";
  String? cNO = "";
  String? quotationNo = "";
  String? tOC = "";
  String? policyType = "";
  String? branch = "";
  String? requestID = "";
  String? requestDate = "";
  String? surveyor = "";
  String? surveyType = "";
  String? surveyStatus = "";
  String? assignStatus = "";
  String? pICSurvey = "";
  String? pICRelation = "";
  String? pICPhone = "";
  String? surveyDate = "";
  String? surveyZone = "";
  String? surveyAddress = "";
  String? surveyAddressDetail = "";
  String? remark = "";
  String? surveyLongitude = "";
  String? surveyLatitude = "";
  String? isFleetDetail = "";
  String? reasonReschedule = "";
  String? reasonReSurvey = "";
  String? surveyReport = "";
  String? autoReleaseF = "";

  Survey();

  Survey.fromJson(Map<String, dynamic> json) {
    aNO = json['ANO'];
    cNO = json['CNO'];
    quotationNo = json['QuotationNo'];
    tOC = json['TOC'];
    policyType = json['PolicyType'];
    branch = json['Branch'];
    requestID = json['RequestID'];
    requestDate = json['RequestDate'];
    surveyor = json['Surveyor'];
    surveyType = json['SurveyType'];
    surveyStatus = json['SurveyStatus'];
    assignStatus = json['AssignStatus'];
    pICSurvey = json['PICSurvey'];
    pICRelation = json['pICRelation'];
    pICPhone = json['PICPhone'];
    surveyDate = json['SurveyDate'];
    surveyZone = json['surveyZone'];
    surveyAddress = json['SurveyAddress'];
    surveyAddressDetail = json['SurveyAddressDetail'];
    remark = json['Remark'];
    surveyLongitude = json['SurveyLongitude'];
    surveyLatitude = json['SurveyLatitude'];
    isFleetDetail = json['IsFleetDetail'];
    reasonReschedule = json['ReasonReschedule'];
    reasonReSurvey = json['ReasonReSurvey'];
    surveyReport = json['SurveyReport'];
    autoReleaseF = json['autoReleaseF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ANO'] = this.aNO;
    data['CNO'] = this.cNO;
    data['QuotationNo'] = this.quotationNo;
    data['TOC'] = this.tOC;
    data['PolicyType'] = this.policyType;
    data['Branch'] = this.branch;
    data['RequestID'] = this.requestID;
    data['RequestDate'] = this.requestDate;
    data['Surveyor'] = this.surveyor;
    data['SurveyType'] = this.surveyType;
    data['SurveyStatus'] = this.surveyStatus;
    data['AssignStatus'] = this.assignStatus;
    data['pICSurvey'] = this.pICSurvey;
    data['pICRelation'] = this.pICRelation;
    data['PICPhone'] = this.pICPhone;
    data['SurveyDate'] = this.surveyDate;
    data['SurveyZone'] = this.surveyZone;
    data['SurveyAddress'] = this.surveyAddress;
    data['SurveyAddressDetail'] = this.surveyAddressDetail;
    data['Remark'] = this.remark;
    data['SurveyLongitude'] = this.surveyLongitude;
    data['SurveyLatitude'] = this.surveyLatitude;
    data['IsFleetDetail'] = this.isFleetDetail;
    data['ReasonReschedule'] = this.reasonReschedule;
    data['ReasonReSurvey'] = this.reasonReSurvey;
    data['SurveyReport'] = this.surveyReport;
    data['autoReleaseF'] = this.autoReleaseF;
    return data;
  }

  Future<Map<String, dynamic>> GetRequestedSurvey(String requestID) async {
    HttpClient httpClient = HttpClient();
    this.requestID = requestID;
    var response = await httpClient.post("Survey/GetRequestedSurvey", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': '', 'data': data.toList()};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }

  Future<Map<String, dynamic>> SubmitRequest() async {
    HttpClient httpClient = HttpClient();
    var response = await httpClient.post("Survey/SubmitRequest", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': ''};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }

  Future<Map<String, dynamic>> GetTaskList(String surveyor) async {
    HttpClient httpClient = HttpClient();
    this.surveyor = surveyor;
    var response = await httpClient.post("Survey/GetTaskList", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': '', 'data': data.toList()};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }

  Future<Map<String, dynamic>> UpdateSurveyStatus() async {
    HttpClient httpClient = HttpClient();
    var response = await httpClient.post("Survey/UpdateSurveyStatus", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': ''};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }
}
