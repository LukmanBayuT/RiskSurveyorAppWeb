import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risk_surveyor_app/model/survey.dart';
import 'package:risk_surveyor_app/screens/login/login.dart';
import 'package:risk_surveyor_app/screens/mkt/request_resurvey.dart';
import 'package:risk_surveyor_app/utils/app_colors.dart';
import 'package:risk_surveyor_app/utils/app_dimension.dart';
import 'package:sizer/sizer.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';
import '../mkt/request_survey.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    RequestedSurveyController requestedSurvey =
        Get.put(RequestedSurveyController());
    requestedSurvey.onInit();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        customBtn: true,
        onBack: () {
          Get.offAll(() => const LoginPage());
        },
        btn: [
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () async {
                Get.to(RequestReSurvey());
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.edit_calendar_sharp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () async {
                Get.to(RequestSurvey());
              },
              heroTag: 'image2',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      appBar: const CustomAppBar(
        title: "SURVEY REQUEST",
      ),
      body: requestedSurvey.obx(
        (data) => ListView.builder(
          padding: AppDimension.mainPadding,
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Card(
                color: AppColors.grey30,
                child: Center(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          data[index]['Sequence'].toString(),
                          style: TextStyle(
                              fontSize: AppDimension.fontSizeSmall,
                              fontWeight: FontWeight.bold,
                              color: AppColors.oonaPurple),
                        ),
                        subtitle: Text(
                          data[index]['QuotationNo'].toString(),
                          style: TextStyle(
                              fontSize: AppDimension.fontSizeSmall,
                              color: AppColors.oonaPurple),
                        ),
                        trailing: Text(
                          data[index]['AssignStatus'].toString(),
                          style: TextStyle(
                              fontSize: AppDimension.fontSizeSmall,
                              color: AppColors.oonaPurple),
                        ),
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Provider extends GetConnect {
  Future<List<dynamic>> GetRequestedSurvey() async {
    var response = await Survey().GetRequestedSurvey("marketing");
    if (response['success'] == true) {
      return response['data'];
    } else {
      return Future.error(response['message']);
    }
  }
}

class RequestedSurveyController extends GetxController
    with StateMixin<List<dynamic>> {
  List<dynamic> cardList = [];
  Map<dynamic, dynamic>? setting = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    Provider().GetRequestedSurvey().then((value) {
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
