import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemCard extends StatelessWidget {
  const MealItemCard({
    super.key,
    required this.mealModel,
    required this.onSelectMeal,
  });

  final MealModel mealModel;
  final void Function(MealModel meal) onSelectMeal;
  String get complexityText {
    return mealModel.complexity.name[0].toUpperCase() +
        mealModel.complexity.name.substring(1);
  }

  String get affordabilityText {
    return mealModel.affordability.name[0].toUpperCase() +
        mealModel.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(mealModel);
        },
        child: Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(mealModel.imageUrl),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      mealModel.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${mealModel.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.schedule, label: affordabilityText)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
