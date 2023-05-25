import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:risk_surveyor_app/screens/svy/survey_recommendation.dart';

class SurveyChecklist extends StatefulWidget {
  SurveyChecklist({Key? key}) : super(key: key);

  static const kInitialPosition = LatLng(-6.2254331, 106.8005475);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;

  @override
  SurveyChecklistState createState() {
    return SurveyChecklistState();
  }
}

class SurveyChecklistState extends State<SurveyChecklist> {
  GoogleMapController? mapController;
  final _formKey = GlobalKey<FormBuilderState>();
  List<Widget> providerList = [];
  TextEditingController textEditingController = TextEditingController();
  late BuildContext draggableSheetContext;
  double minExtent = 0;
  static const double maxExtent = 1;
  bool isExpanded = false;
  double initialExtent = 0;
  TextEditingController txtConHospital = TextEditingController();
  TextEditingController txtConAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // _formKey.currentState?.patchValue({
    //   'pic':'Putra Rizki Pradana',
    //   'insuredName':'Putra Rizki Pradana',
    //   'insuredAddress':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
    //   'surveyLocation':'Plaza Asia Lt. 27, Jl. Jend Sudirman Kav. 59, Senayan, Kebayoran Baru, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190'
    // });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        visible: !isExpanded,
        child: FloatingActionButton.extended(
            label: const Text('Next'),
            icon: const Icon(Icons.navigate_next),
            onPressed: () async {
              Get.to(SurveyRecommendation());
            }),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Survey Form'),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FormBuilder(
                key: _formKey,
                child: FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Column(
                      children: [
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Bagian Depan'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nKap Mesin'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nGrill'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nBumper'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu depan kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu depan kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu kabut'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Bagian Kanan'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nFender Depan Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPintu Depan Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLantai Kendaraan Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPintu Belakang Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPillar Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nFender Belakang Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nVelg Depan Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nVelg Belakang Kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Bagian Belakang'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nKap Bagasi'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nBumper'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu belakang kanan'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu belakang kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLampu kabut'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Bagian Kiri'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nFender Depan Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPintu Depan Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nLantai Kendaraan Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPintu Belakang Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nPillar Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nFender Belakang Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nVelg Depan Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nVelg Belakang Kiri'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Bagian Lainnya'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nRoof/Kap Atas Luar'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Baret atau lecet'),
                                          FormBuilderFieldOption(value: 'Penyok'),
                                          FormBuilderFieldOption(value: 'Retak/Pecah/Sobek'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nBagian Bawah dan Kolong'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Ada kerusakan'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nRuang Mesin'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(
                                              value:
                                                  'Terdapat retak/pecah/sobek/penyok/korosi/kebocoran pelumas/kondisi sekeliling ruang mesin tampak pernah dicat ulang'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nRuang Bagasi'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak ada kerusakan'),
                                          FormBuilderFieldOption(
                                              value:
                                                  'Terdapat tanda-tanda kerusakan seperti terlihat lubang, retakan, celah, bagasi sulit untuk dibuka dan ditutup'),
                                          FormBuilderFieldOption(value: 'Terdapat karat skala besar atau kerusakan yang disebabkan air'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nSet Ban Serep'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Terdapat set ban serep'),
                                          FormBuilderFieldOption(value: 'Tidak terdapat set ban serep'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nInterior Roof Kabin'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Kondisi normal dan bersih'),
                                          FormBuilderFieldOption(value: 'Kondisi normal namun kotor'),
                                          FormBuilderFieldOption(value: 'Kondisi abnormal/terdapat kerusakan namun bersih'),
                                          FormBuilderFieldOption(value: 'Kondisi abnormal/terdapat kerusakan dan kotor'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nInterior Kabin'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Kondisi normal dan tidak ada kerusakan'),
                                          FormBuilderFieldOption(value: 'Kondisi abnormal dan atau terdapat kerusakan'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nJok Mobil'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Kondisi normal dan kursi mobil dapat disetel dan berfungsi dengan baik'),
                                          FormBuilderFieldOption(value: 'Kain atau kulit pelapis tampak aus, robek, terkena noda, atau kerusakan lain'),
                                          FormBuilderFieldOption(
                                              value:
                                                  'Kursi mobil tidak dapat disetel dan tidak berfungsi dengan baik / electrical seat adjustment tidak berfungsi'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[400],
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Elektrikal'),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nDashboard'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Lampu indikator, layar, layar digital, audio sistem berfungsi dengan baik'),
                                          FormBuilderFieldOption(value: 'Lampu indikator, layar, layar digital, audio sistem tidak berfungsi dengan baik'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nSpeedometer'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Berfungsi Normal'),
                                          FormBuilderFieldOption(value: 'Tidak berfungsi normal'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nBagian Bawah Jok'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Tidak terdapat korosi/karat'),
                                          FormBuilderFieldOption(value: 'Terdapat korosi/karat'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nSabuk Pengaman'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Kondisi normal dan tidak ada korosi/karat'),
                                          FormBuilderFieldOption(value: 'Kondisi tidak normal dan atau terdapat korosi/karat'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nAirbag'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Normal'),
                                          FormBuilderFieldOption(value: 'Tidak Normal'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('\nApakah unit kendaraan terdapat indikasi bekas terdampak banjir?'),
                                      subtitle: FormBuilderCheckboxGroup<String>(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        name: 'languages',
                                        // initialValue: const ['Dart'],
                                        options: const [
                                          FormBuilderFieldOption(value: 'Ya'),
                                          FormBuilderFieldOption(value: 'Tidak'),
                                        ],
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(1),
                                          FormBuilderValidators.maxLength(3),
                                        ]),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
