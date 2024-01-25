import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/caterogies.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/drawer.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<MealModel> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilter;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 3),
  //     ),
  //   );
  // }

  // void _toggleMealFavouriteStatus(MealModel mealModel) {
  //   final isExisting = _favouriteMeals.contains(mealModel);

  //   setState(() {
  //     if (isExisting) {
  //       _favouriteMeals.remove(mealModel);
  //       _showInfoMessage('Meal is no longer a favorite');
  //     } else {
  //       _favouriteMeals.add(mealModel);
  //       _showInfoMessage('Meal is marked as a favorite');
  //     }
  //   });
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const FiltersScreen(),
      //   ),
      // );
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableFoods = meals.where((food) {
      if ((_selectedFilters[Filter.glutenFree]! && !food.isGlutenFree) ||
          (_selectedFilters[Filter.lactoseFree]! && !food.isLactoseFree) ||
          (_selectedFilters[Filter.vegetarian]! && !food.isVegetarian) ||
          (_selectedFilters[Filter.vegan]! && !food.isVegan)) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      // onToggleFavourite: _toggleMealFavouriteStatus,
      availableFoods: availableFoods,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);

      activePage = MealsScreen(
        meals: favouriteMeals,
        // onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_rounded), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
