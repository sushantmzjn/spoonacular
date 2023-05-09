import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spoonacular/provider/favourite_provider.dart';
import 'package:spoonacular/services/recipe_services.dart';
import 'package:spoonacular/view/common_widget/snackbar.dart';

import '../detail_page.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final favData = ref.watch(favouriteProvider);
    final favId = favData.map((e) => e.id).toList();
    print(favId);
    final recipe = ref.watch(getRecipe);
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      body: CustomScrollView(
        key: const PageStorageKey<String>('page'),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 210,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Spoonacular', style: TextStyle(letterSpacing: 0.5, fontSize: 20.0),
              ),
              titlePadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              background: Image.asset('assets/images/cover_image.jpg', fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: Text('Recipe', style: TextStyle(fontSize: 20.sp,letterSpacing: 1),),
                ),
                recipe.when(
                    data: (data){
                      return PageStorage(
                        bucket: PageStorageBucket(),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=> Detail(recipe: data[index]), transition: Transition.leftToRightWithFade);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: Offset(3, 3))
                                        ],
                                        image: DecorationImage(
                                          image: NetworkImage(data[index].image,),
                                          fit: BoxFit.fitWidth,
                                        )
                                      ),
                                      child: Text(data[index].title,textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.sp,
                                          color: Colors.white,
                                          backgroundColor: Colors.black.withOpacity(0.1),
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w700
                                        ),),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                          onPressed: (){
                                            final res = ref.read(favouriteProvider.notifier).add(data[index]);
                                            if(res == 'Already Added to Favourite'){
                                              SnackShow.showFailure(context, res);
                                            }else{
                                              SnackShow.showSuccess(context, res);
                                            }
                                          },
                                          icon: Icon(CupertinoIcons.heart_fill, size: 28,
                                          color: favId== data[index].id ? Colors.red : Colors.black,
                                          )),
                                  )
                                ],
                              ),
                            );
                        }),
                      );
                    },
                    error: (error, stack)=> Center(child: Text(error.toString()),),
                    loading: ()=> Center(child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
