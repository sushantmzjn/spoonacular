

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:spoonacular/main.dart';
import 'package:spoonacular/model/recipe.dart';

import '../model/favourite.dart';

final favouriteProvider = StateNotifierProvider<FavouriteProvider, List<Favourite>>((ref) => FavouriteProvider(ref.watch(box)));

class FavouriteProvider extends StateNotifier<List<Favourite>>{
  FavouriteProvider(super.state);

  //add to favourite
String add(Recipe recipe){
  if(state.isEmpty){
    final newFavourite = Favourite(
        id: recipe.id,
        title: recipe.title,
        image: recipe.image
    );
    final box = Hive.box<Favourite>('favourite').add(newFavourite);
    state = [...state, newFavourite];
    return 'Added to Favourite';
  }else{
    final prev = state.firstWhere((element) => element.id == recipe.id,
    orElse: ()=> Favourite(id: 0, title: 'no data', image: 'image'));

    if(prev.title == 'no data'){
      final newFavourite = Favourite(
          id: recipe.id,
          title: recipe.title,
          image: recipe.image
      );
      final box =Hive.box<Favourite>('favourite').add(newFavourite);
      state = [...state, newFavourite];
      return 'Added to Favourite';
    }else{
      return 'Already Added to Favourite';
    }
  }
}

//remove from favourite
void remove(Favourite favourite){
  favourite.delete();
  state.remove(favourite);
  state = [...state];
}

}