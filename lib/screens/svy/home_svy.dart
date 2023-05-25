import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:risk_surveyor_app/screens/svy/survey_detail.dart';
import 'package:sizer/sizer.dart';
import '../../model/survey.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';
import '../login/login.dart';

class HomeSVY extends StatefulWidget {
  const HomeSVY({super.key});

  @override
  State<HomeSVY> createState() => _HomeSVYState();
}

class _HomeSVYState extends State<HomeSVY> {
  @override
  Widget build(BuildContext context) {
    TaskListController taskList = Get.put(TaskListController());
    taskList.onInit();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'SURVEY LIST',
      ),
      body: taskList.obx(
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
                          style: TextStyle(fontSize: AppDimension.fontSizeSmall, fontWeight: FontWeight.bold, color: AppColors.oonaPurple),
                        ),
                        subtitle: Text(
                          "${data[index]['QuotationNo'].toString()} - ${data[index]['TOC'].toString()}"
                          "\n"
                          "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data[index]['SurveyDate'].toString()))} - ${data[index]['STime1'].toString().split('-')[0]}",
                          style: TextStyle(fontSize: AppDimension.fontSizeSmall, color: AppColors.oonaPurple),
                        ),
                        trailing: Text(
                          "${data[index]['SType'].toString()} (${data[index]['SStatus'].toString()})",
                          style: TextStyle(fontSize: AppDimension.fontSizeSmall, color: AppColors.oonaPurple),
                        ),
                        dense: true,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Get.to(SurveyDetail(), arguments: data[index]);
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        customBtn: true,
        onBack: () {
          Get.offAll(LoginPage());
        },
        btn: [
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () {
                setState(() {

                });
              },
              heroTag: 'image2',
              tooltip: 'Refresh',
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}

class Provider extends GetConnect {
  Future<List<dynamic>> GetTaskList() async {
    var response = await Survey().GetTaskList("surveyor");
    if (response['success'] == true) {
      return response['data'];
    } else {
      return Future.error(response['message']);
    }
  }
}

class TaskListController extends GetxController with StateMixin<List<dynamic>> {
  List<dynamic> cardList = [];
  Map<dynamic, dynamic>? setting = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    Provider().GetTaskList().then((value) {
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
