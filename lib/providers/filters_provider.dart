import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/data.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; //not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final activeFilters = ref.watch(filterProvider);
  ref.watch(
      mealsProvider); //Whenever the watch value changes the value of the filter provider is also changed.

  return meals.where((element) {
    if ((activeFilters[Filter.glutenFree]! && !element.isGlutenFree) ||
        (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) ||
        (activeFilters[Filter.vegetarian]! && !element.isVegetarian) ||
        (activeFilters[Filter.vegan]! && !element.isVegan)) {
      return false;
    }
    return true;
  }).toList();
});
