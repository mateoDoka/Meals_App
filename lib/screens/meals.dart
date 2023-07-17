import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/widgets/meals_item_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.meals, this.title, super.key});
  final String? title;
  final List<MealModel> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: ((context, index) => MealItemCard(mealModel: meals[index])),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text(
              "Nothing here",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select different category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
