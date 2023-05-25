import 'package:flutter/material.dart';
import 'package:risk_surveyor_app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool nextBtn;
  final bool customBtn;
  final List<Widget> btn;

  const CustomFAB({
    super.key,
    this.onNext,
    this.onBack,
    this.nextBtn = false,
    this.customBtn = false,
    this.btn = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    if (nextBtn && !customBtn) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColors.oonaPurple,
                onPressed: () {
                  onBack!();
                },
                child: const Icon(Icons.navigate_before),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    backgroundColor: AppColors.oonaPurple,
                    onPressed: () {
                      onNext!();
                    },
                    child: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (customBtn) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColors.oonaPurple,
                onPressed: () {
                  onBack!();
                },
                child: const Icon(Icons.navigate_before),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: btn,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              backgroundColor: AppColors.oonaPurple,
              onPressed: () {
                onBack!();
              },
              child: const Icon(Icons.navigate_before),
            ),
          ],
        ),
      );
    }
  }
}
