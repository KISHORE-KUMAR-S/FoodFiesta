import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.mealModel,
    required this.onSelectMeal,
  }) : super(key: key);

  final MealModel mealModel;
  final Function(BuildContext context, MealModel mealModel) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    final String complexityLabel = mealModel.complexity.name[0].toUpperCase() +
        mealModel.complexity.name.substring(1);

    final String affordabilityLabel =
        mealModel.affordability.name[0].toUpperCase() +
            mealModel.affordability.name.substring(1);

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onSelectMeal(context, mealModel), // Corrected here
        child: Stack(
          children: [
            Hero(
              tag: mealModel.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(mealModel.imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.black12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mealModel.title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealItemTrait(
                              iconData: Icons.schedule,
                              label: "${mealModel.duration} min",
                            ),
                            const SizedBox(width: 10),
                            MealItemTrait(
                              iconData: Icons.work,
                              label: complexityLabel,
                            ),
                            const SizedBox(width: 10),
                            MealItemTrait(
                              iconData: Icons.attach_money,
                              label: affordabilityLabel,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
