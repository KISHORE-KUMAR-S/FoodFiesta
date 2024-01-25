import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<MealModel> meals;

  void selectMeal(BuildContext context, MealModel model) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDetailsScreen(
        mealModel: model,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = const Center(
      child: Text('The list is empty'),
    );

    if (meals.isNotEmpty) {
      bodyContent = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          mealModel: meals[index],
          onSelectMeal: ((context, mealModel) =>
              selectMeal(context, mealModel)),
        ),
      );
    }

    if (title == null) {
      return bodyContent;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: bodyContent,
      );
    }
  }
}
