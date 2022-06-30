import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final String? iconImage;
  final Color textColor;
  final Color buttonColor;
  final double verticalPadding;
  final double? fontSize;
  const MainButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    required this.buttonColor,
    this.iconImage,
    required this.verticalPadding,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
        ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconImage != null
                ? Flexible(
                    child: Image(
                      image: AssetImage(iconImage!),
                      height: 26.sp,
                      width: 26.sp,
                    ),
                  )
                : Container(),
            SizedBox(width: 1.w),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize ?? 16.sp,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
