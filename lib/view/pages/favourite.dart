import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spoonacular/provider/favourite_provider.dart';
import 'package:spoonacular/view/detail_page.dart';

import '../../model/recipe.dart';

class Favourite extends ConsumerWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final favData = ref.watch(favouriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite', style: TextStyle(letterSpacing: 1),),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark
        ),
      ),
      body: favData.isEmpty ? const Center(child: Text('Favourite list is empty')) :  ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
          itemCount: favData.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      // Get.to(()=>Detail());
                      print( favData[index].id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(3, 3))
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: 90.h,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(favData[index].image, fit: BoxFit.fitWidth,))),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(favData[index].title, textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16.sp)),
                                ),
                                IconButton(
                                    onPressed: (){
                                      ref.read(favouriteProvider.notifier).remove(favData[index]);
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,))
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
