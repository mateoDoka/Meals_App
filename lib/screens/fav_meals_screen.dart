import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/provider/favorites_provider.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/widgets/meals_item_card.dart';
import 'package:provider/provider.dart';

class FavMealsScreen extends StatelessWidget {
  const FavMealsScreen({this.title, super.key});
  final String? title;

  void selectMeal(BuildContext context, MealModel meal) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          mealModel: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context);
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
    var favList = favoritesProvider.favoritesMeals;
    if (favList.isNotEmpty) {
      content = ListView.builder(
        itemCount: favList.length,
        itemBuilder: (ctx, index) => MealItemCard(
          mealModel: favList[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
