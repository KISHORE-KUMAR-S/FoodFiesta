import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.mealModel,
    // required this.onToggleFavourite,
  });

  final MealModel mealModel;
  // final void Function(MealModel mealModel) onToggleFavourite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealModel.title),
        actions: [
          IconButton(
            // onPressed: () => onToggleFavourite(mealModel),
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(
                      mealModel); //inside function we shouldn't use ref.watch()

              // void _showInfoMessage(String message) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? "Added to Favourites"
                      : "Removed from Favourites"),
                  duration: const Duration(seconds: 2),
                ),
              );
              // }
            },
            icon: const Icon(Icons.star_border_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              mealModel.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            for (final ingredient in mealModel.ingredients) Text(ingredient),
            const SizedBox(height: 20),
            Text(
              'Steps to cook',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            for (final step in mealModel.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
