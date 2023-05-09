import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spoonacular/model/food_item.dart';
import 'package:spoonacular/model/calorie.dart';
import 'package:spoonacular/provider/total_calorie_provider.dart';
import 'package:spoonacular/view/common_widget/custom_textform.dart';
import 'package:spoonacular/view/common_widget/snackbar.dart';

import '../../provider/autoValidate_provider.dart';
import '../../provider/food_item_provider.dart';

class Calorie extends ConsumerStatefulWidget {
  const Calorie({Key? key}) : super(key: key);

  @override
  ConsumerState<Calorie> createState() => _CalorieState();
}

class _CalorieState extends ConsumerState<Calorie> {

  TextEditingController foodNameController = TextEditingController();
  TextEditingController calorieController = TextEditingController();
  TextEditingController updateFoodNameController = TextEditingController();
  TextEditingController updateCalorieController = TextEditingController();

  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(autoValidateMode);
    final foodItemData = ref.watch(foodItemProvider);
    final calorie = ref.watch(totalCalorieProvider);
    print(calorie.length);
    final totalCalorie = ref.watch(foodItemProvider.notifier).total;
    print(foodItemData.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Track', style: TextStyle(letterSpacing: 1),),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              children: [
                Text('Total Calorie Intake :', style: TextStyle(fontSize: 16.sp),),
                Spacer(),
                Text(totalCalorie.toString(), style: TextStyle(fontSize: 16.sp),),
                Spacer()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 250.h,
              decoration: BoxDecoration(
                color: const Color(0xffefefef),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.green.withOpacity(0.5))
              ),
              child: ListView.builder(
                  itemCount: foodItemData.length,
                  itemBuilder: (context, index){
                    final now = DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
                    print(now);
                    return now == foodItemData[index].dateTime  ?  Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 4),
                          title: Text(foodItemData[index].foodName),
                          subtitle: Text(foodItemData[index].dateTime),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(foodItemData[index].calorie.toString()),
                              SizedBox(width: 5.w,),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.green.withOpacity(0.4),
                              ),
                              IconButton(onPressed: ()async{
                              await showModal(
                                    configuration: const FadeScaleTransitionConfiguration(
                                        transitionDuration: Duration(milliseconds: 400)
                                    ),
                                    context: context, builder: (builder){
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState){
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(8.0),
                                          title: Center(child: Text('Update')),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Form(
                                                key: _form,
                                                autovalidateMode: mode,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CustomTextFormField(
                                                      controller: updateFoodNameController..text = foodItemData[index].foodName,
                                                      keyboardType: TextInputType.text,
                                                      labelText: 'Food',
                                                      validator: (val){
                                                        if(val!.trim().isEmpty){
                                                          return 'required';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(height: 8.h,),
                                                    CustomTextFormField(
                                                      controller: updateCalorieController..text = foodItemData[index].calorie.toString(),
                                                      keyboardType: TextInputType.number,
                                                      labelText: 'Calorie',
                                                      validator: (val){
                                                        if(val!.trim().isEmpty){
                                                          return 'required';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 12.h,),
                                              ElevatedButton(
                                                  onPressed: (){
                                                    _form.currentState!.save();
                                                    FocusScope.of(context).unfocus();
                                                    if(_form.currentState!.validate()){
                                                      final foodItems = FoodItem(
                                                          foodName: updateFoodNameController.text.trim(),
                                                          calorie: int.parse(updateCalorieController.text.trim()),
                                                          dateTime: DateTime.now().toString());
                                                      final res = ref.read(foodItemProvider.notifier).update(index, foodItems);
                                                      if(res =='Updated'){
                                                        SnackShow.showSuccess(context, res);
                                                        Navigator.of(context).pop();
                                                        foodNameController.clear();
                                                        calorieController.clear();
                                                      }
                                                    }else{
                                                      ref.read(autoValidateMode.notifier).autoValidate();
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      minimumSize: Size(double.infinity, 35.0)
                                                  ),
                                                  child: Text('Update',style: TextStyle(fontSize: 14.sp),))
                                            ],
                                          ),
                                        );
                                      });
                                });
                              },
                                  icon: Icon(Icons.edit,color: Colors.green,))
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          height: 0,
                          color: Colors.green.withOpacity(0.2),
                        )
                      ],
                    ): Container();
                  }),
            ),
          ),
          Container(
            height: 250,
            child: ListView.builder(
                itemCount: calorie.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Text(calorie[index].totalCalorie.toString()),
                      Text(calorie[index].dateTime.toString()),
                    ],
                  );
            }),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await showModal(
            configuration: const FadeScaleTransitionConfiguration(
              transitionDuration: Duration(milliseconds: 400)
            ),
              context: context, builder: (builder){
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Center(child: Text('Add Meal')),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: _form,
                              autovalidateMode: mode,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextFormField(
                                    controller: foodNameController,
                                    keyboardType: TextInputType.text,
                                    labelText: 'Food',
                                    validator: (val){
                                      if(val!.trim().isEmpty){
                                        return 'required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 8.h,),
                                  CustomTextFormField(
                                    controller: calorieController,
                                    keyboardType: TextInputType.number,
                                    labelText: 'Calorie',
                                    validator: (val){
                                      if(val!.trim().isEmpty){
                                        return 'required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h,),
                            ElevatedButton(
                                onPressed: (){
                                  _form.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  if(_form.currentState!.validate()){
                                    final foodItems = FoodItem(
                                        foodName: foodNameController.text.trim(),
                                        calorie: int.parse(calorieController.text.trim()),
                                        dateTime: DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()))
                                    );
                                    final now = DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
                                    final d =  DateFormat('yyyy-MM-dd').format(DateTime.parse(foodItemData.map((e) => e.dateTime).toString()));
                                    print(d);
                                    if(foodItemData.isNotEmpty &&
                                    now == d
                                    ){
                                      final c = TotalCalorie(totalCalorie: totalCalorie+ int.parse(calorieController.text.toString()),
                                          dateTime: DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()))
                                      );
                                      ref.read(totalCalorieProvider.notifier).totalCalorieUpdate(0, c);

                                    }else{
                                      final c = TotalCalorie(totalCalorie: totalCalorie, dateTime: DateTime.now().toString());
                                      ref.read(totalCalorieProvider.notifier).addCalorie(c);
                                    }

                                    final res = ref.read(foodItemProvider.notifier).add(foodItems);
                                    if(res=='Success'){
                                      SnackShow.showSuccess(context, res);
                                      Navigator.of(context).pop();
                                      foodNameController.clear();
                                      calorieController.clear();
                                    }
                                  }else{
                                    ref.read(autoValidateMode.notifier).autoValidate();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 35.0)
                                ),
                                child: Text('Submit',style: TextStyle(fontSize: 14.sp),))
                          ],
                        ),
                      );
                    });
          });
        },
        mini: true,
        child: Icon(Icons.add),
      ),
    );
  }
}
