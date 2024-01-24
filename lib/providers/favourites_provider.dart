import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';

class FavouriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavouriteMealsNotifier(super.state);

  void toggleMealFavouriteStatus(MealModel mealModel) {
    final mealIsFavourite = state.contains(mealModel);

    if (mealIsFavourite) {
      state = state
          .where((element) => element.id != mealModel.id)
          .toList(); //To remove a meal
    } else {
      state = [
        ...state,
        mealModel
      ]; //To pull out all the elements that are stored in that list and add them as individual elements to this new list
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<MealModel>>(
  (ref) => FavouriteMealsNotifier([]),
);
