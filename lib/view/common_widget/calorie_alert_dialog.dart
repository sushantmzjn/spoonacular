import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalorieAlertDialog extends StatefulWidget {

  TextEditingController? mealController;
  TextEditingController? calorieController;
  Widget? suffixIcon;
  void Function(String)? onChanged;
  void Function()? onPressed;
  String? mealLabelText;
  String? calorieLabelText;
  TextInputType? mealKeyboardType;
  TextInputType? calorieKeyboardType;
  String? Function(String?)? mealValidator;
  String? Function(String?)? calorieValidator;

  CalorieAlertDialog({
    this.mealController,
    this.calorieController,
    this.suffixIcon,
    this.onChanged,
    this.onPressed,
    this.mealLabelText,
    this.calorieLabelText,
    this.mealKeyboardType,
    this.calorieKeyboardType,
    this.mealValidator,
    this.calorieValidator,
  });

  @override
  State<CalorieAlertDialog> createState() => _CalorieAlertDialogState();
}

class _CalorieAlertDialogState extends State<CalorieAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        alignment: Alignment.bottomCenter,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 16,
              controller: widget.mealController,
              onChanged: widget.onChanged,
              keyboardType: widget.mealKeyboardType,
              textInputAction: TextInputAction.next,
              validator: widget.mealValidator,
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                labelText: widget.mealLabelText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            TextFormField(
              controller: widget.calorieController,
              onChanged: widget.onChanged,
              keyboardType: widget.calorieKeyboardType,
              textInputAction: TextInputAction.next,
              validator: widget.calorieValidator,
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                labelText: widget.calorieLabelText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            SizedBox(height: 8.h,),
            ElevatedButton(
                onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 25.h)
              ),
                child: Text('Submit', style: TextStyle(fontSize: 14.sp),),
            )
          ],
        ));
  }
}
