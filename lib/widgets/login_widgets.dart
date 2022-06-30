import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 38.0,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
  Color textColor = Colors.white,
  bool toUpper = false,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: width,
      height: height,
      child: MaterialButton(
        color: color,
        onPressed: function,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Text(
            toUpper ? text.toUpperCase() : text,
            style: TextStyle(fontSize: 14.0, color: textColor),
          ),
        ),
      ),
    );

Widget defaultTFF({
  required String label,
  IconData? prefix,
  IconData? suffix,
  required TextInputType inputType,
  bool isPassword = false,
  required TextEditingController controller,
  VoidCallback? suffuxPressed,
  required String? Function(String?) validate,
  Function()? ontap,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  Color? filledColor,
  Color? hintColor,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        style: TextStyle(
          color: hintColor ?? Colors.black,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: hintColor ?? Colors.grey,
          ),
          fillColor: filledColor ?? Colors.white,
          filled: true,
          hintText: label,

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          // prefixIcon: Icon(prefix),
          //more specific
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffuxPressed,
                )
              : null,
        ),
        keyboardType: inputType,
        obscureText: isPassword,
        controller: controller,
        validator: validate,
        onTap: ontap,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
      ),
    );

Widget divider() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

Future<dynamic> navigateTo({
  required BuildContext context,
  required Widget screen,
}) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

Future<dynamic> navigateAndfinish({
  required BuildContext context,
  required Widget screen,
}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (route) => false,
  );
}
