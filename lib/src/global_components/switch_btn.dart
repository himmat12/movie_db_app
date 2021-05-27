import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

Widget switchBtnBuilder({
  String? text1,
  String? text2,
  Color? color,
  Color? selectedColor,
  Color? textColor,
  BorderRadiusGeometry? borderRadius,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
}) {
  final _controller = Get.find<UtilityController>();

  return Obx(
    () => Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color ?? secondaryDarkBlue,
        border: border ??
            const Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _controller.toggleSwitchBtnState(SwitchBtnState.option1);
            },
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _controller.switchBtnState == SwitchBtnState.option1
                    ? primaryblue
                    : secondaryDarkBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                text1 ?? 'text1',
                style: TextStyle(
                  color: textColor ?? primaryWhite,
                  fontSize: n - 5,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _controller.toggleSwitchBtnState(SwitchBtnState.option2);
            },
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _controller.switchBtnState == SwitchBtnState.option2
                    ? primaryblue
                    : secondaryDarkBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                text2 ?? 'text2',
                style: TextStyle(
                  color: textColor ?? primaryWhite,
                  fontSize: n - 5,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
