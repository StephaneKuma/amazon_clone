import 'package:amazon_clone/src/ui/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.color,
    this.btnColor = kPrimaryColor,
    this.style,
    required this.onTap,
    this.isLoading = false,
    this.secondary = false,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Color? btnColor;
  final TextStyle? style;
  final VoidCallback onTap;
  final bool isLoading;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60.0),
          backgroundColor: secondary ? null : btnColor,
          side: BorderSide(
            color: btnColor ?? kPrimaryColor,
          )),
      child: isLoading
          ? SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: color ?? kPrimaryColor,
                backgroundColor: (color ?? kPrimaryColor).withOpacity(.3),
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: style ??
                  TextStyle(
                    color: color ?? Colors.black,
                  ),
            ),
    );
  }
}
