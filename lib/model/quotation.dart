import 'package:risk_surveyor_app/model/http_client.dart';

class Quotation {
  String? aNO = "";
  String? cNO= "";
  String? quotationNo= "";
  String? tOC= "";
  String? policyType= "";
  String? branch= "";

  Quotation();

  Quotation.fromJson(Map<String, dynamic> json) {
    aNO = json['ANO'];
    cNO = json['CNO'];
    quotationNo = json['QuotationNo'];
    tOC = json['TOC'];
    policyType = json['PolicyType'];
    branch = json['Branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ANO'] = this.aNO;
    data['CNO'] = this.cNO;
    data['QuotationNo'] = this.quotationNo;
    data['TOC'] = this.tOC;
    data['PolicyType'] = this.policyType;
    data['Branch'] = this.branch;
    return data;
  }

  Future<Map<String, dynamic>> GetQuotation(String quotationNo) async {
    HttpClient httpClient = HttpClient();
    this.quotationNo = quotationNo;
    var response = await httpClient.post("Quotation/GetQuotation", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': '', 'data': data.toList()};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }
  Future<Map<String, dynamic>> GetQuotationR(String quotationNo) async {
    HttpClient httpClient = HttpClient();
    this.quotationNo = quotationNo;
    var response = await httpClient.post("Quotation/GetQuotationR", toJson());
    if (response!['IsSuccess'] == true) {
      var data = response['Data'];
      return {'success': true, 'message': '', 'data': data.toList()};
    } else {
      return {'success': false, 'message': response['Message'].toString()};
    }
  }


}