import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:risk_surveyor_app/screens/svy/survey_recommendation.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../model/survey_result.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimension.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_fab.dart';

class SurveyIntElectricalVid extends StatefulWidget {
  const SurveyIntElectricalVid({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SurveyIntElectricalVid> createState() => _SurveyIntElectricalVidState();
}

class _SurveyIntElectricalVidState extends State<SurveyIntElectricalVid> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  void selectVideos() async {
    final XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: 10));
    if (file != null) {
      imageFileList!.add(file);
    }
    await _playVideo(file);
    //setState(() {});
  }

  void takeVideo() async {
    final XFile? file = await imagePicker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
    if (file != null) {
      imageFileList!.add(file);
    }
    await _playVideo(file);
    //setState(() {});
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      controller = VideoPlayerController.file(File(file.path));
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return Text(
        style: TextStyle(fontSize: AppDimension.fontSizeSmall, color: AppColors.oonaPurple),
        'Klik ikon kamera pada perangkat anda.'
        '\n'
        'Ambil video sejelas mungkin.'
        '\n'
        '\n'
        'atau'
        '\n'
        '\n'
        'Pilih video dari galery'
        '\n'
        '\n',
        textAlign: TextAlign.center,
      );
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () async {
            if (_controller!.value.isPlaying) {
              await _controller!.pause();
            } else {
              await _controller!.play();
            }
          },
          child: AspectRatioVideo(_controller),
        ),
      ),
    );
  }

  var data = Get.arguments[0];
  SurveyResult surveyResult = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "SURVEY FORM",
      ),
      body: Container(
        padding: AppDimension.mainPadding,
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: AppColors.grey30,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Elektrikal (Power window, buka tutup pintu elektrik, lock pintu mobil seluruh bagian mobil)",
                        style: TextStyle(
                          fontSize: AppDimension.fontSizeSmall,
                          fontWeight: FontWeight.bold,
                          color: AppColors.oonaPurple,
                        ),
                      ),
                    ),
                    _previewVideo()
                  ],
                ),
              ),
            ),
          ],
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
                selectVideos();
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.mediumTurquoise,
              onPressed: () {
                takeVideo();
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.oonaPurple,
              onPressed: () async {
                if (_controller != null) {
                  await _controller!.pause();
                }
                Get.to(SurveyRecommendation(), arguments: [data,surveyResult]);
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

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller, {super.key});

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
