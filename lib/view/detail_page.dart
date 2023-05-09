import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonacular/model/recipe.dart';
import 'package:readmore/readmore.dart';
import '../services/recipe_services.dart';

class Detail extends ConsumerWidget {
  final Recipe recipe;

  Detail({ required this.recipe,});

  @override
  Widget build(BuildContext context, ref) {
    final recipeDetailData = ref.watch(getRecipeDetail(recipe.id));
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      appBar: AppBar(
        title: const Text(
          'Recipe Details',
          style: TextStyle(letterSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: recipeDetailData.when(
          data: (data) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    child: Image.network(
                      recipe.image,
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Ingredients :',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          letterSpacing: 1),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 80.h,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.analyzedInstructions.length,
                        itemBuilder: (context, index) {
                          final steps = data.analyzedInstructions[index].steps;
                          return Container(
                            alignment: Alignment.center,
                            height: 80.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: steps.length,
                                itemBuilder: (context, position) {
                                  final step = steps[position];
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: step.ingredients.length,
                                    itemBuilder: (context, i) {
                                      final ingredient = step.ingredients[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ingredient.image.isEmpty
                                                ? Text('image not found')
                                                : Image.network(
                                                    'https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}',
                                                    scale: 1.5),
                                            Spacer(),
                                            Text(ingredient.name),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      'Instruction :',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ReadMoreText(
                        data.instructions,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Show less',
                        trimLines: 10,
                        trimMode: TrimMode.Line,
                        textAlign: TextAlign.left,
                        moreStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                        lessStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 10.0, vertical: 8.0),
                  //   child: Text(
                  //     'Steps :',
                  //     style: TextStyle(
                  //         fontSize: 16.sp,
                  //         color: Colors.blue,
                  //         letterSpacing: 1),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.red,
                  //   height: 200,
                  //   width: double.infinity,
                  //   child: ListView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemCount: data.analyzedInstructions.length,
                  //       itemBuilder: (context, index) {
                  //         final steps = data.analyzedInstructions[index].steps;
                  //         return Container(
                  //           height: 200,
                  //           width: double.infinity,
                  //           child: ListView.builder(
                  //               // physics: NeverScrollableScrollPhysics(),
                  //               itemCount: steps.length,
                  //               itemBuilder: (context, position) {
                  //                 final step = steps[position];
                  //                 return Column(
                  //                   children: [
                  //                     Text(step.step),
                  //                   ],
                  //                 );
                  //               }),
                  //         );
                  //       }),
                  // )
                ],
              ),
            );
          },
          error: (error, stack) => Center(child: Text('$error')),
          loading: () => Center(
                  child: CupertinoActivityIndicator(
                radius: 18,
                color: Colors.blue,
              ))),
    );
  }
}
