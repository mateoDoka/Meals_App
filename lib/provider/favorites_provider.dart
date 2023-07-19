import 'package:flutter/material.dart';
import 'package:meals_app/data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.vegan: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class FavoritesProvider extends ChangeNotifier {
  final List<MealModel> favoritesMeals = [];
  List<MealModel> fileteredMeals = [];
  Map<Filter, bool> selectedFilters = kInitialFilters;
  List<MealModel> avaibleMeals = [];

  var glutenFreFilterSet = false;
  var lactoseFreFilterSet = false;
  var veganFilterSet = false;
  var vegetarianFilterSet = false;

  setFilters() {
    glutenFreFilterSet = selectedFilters[Filter.glutenFree]!;
    lactoseFreFilterSet = selectedFilters[Filter.lactoseFree]!;
    veganFilterSet = selectedFilters[Filter.vegan]!;
    vegetarianFilterSet = selectedFilters[Filter.vegetarian]!;
  }

  setGluttenFree(value) {
    glutenFreFilterSet = value;
    initAvaibleMeals();
    notifyListeners();
  }

  setLactoseFree(value) {
    lactoseFreFilterSet = value;
    initAvaibleMeals();
    notifyListeners();
  }

  setVeganFree(value) {
    veganFilterSet = value;
    initAvaibleMeals();
    notifyListeners();
  }

  setVegetarianFree(value) {
    vegetarianFilterSet = value;
    initAvaibleMeals();
    notifyListeners();
  }

//prints the meals that will be displayed after choosing the  category
  void initAvaibleMeals() {
    avaibleMeals = dummyMeals.where((meal) {
      if (glutenFreFilterSet && !meal.isGlutenFree) {
        return false;
      }
      if (lactoseFreFilterSet && !meal.isLactoseFree) {
        return false;
      }
      if (veganFilterSet && !meal.isVegetarian) {
        return false;
      }
      if (vegetarianFilterSet && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }

  // select categroy in the first page
  void selectCategory(BuildContext context, CategoryModel categoryModel) {
    fileteredMeals = avaibleMeals
        .where((meal) => meal.categories.contains(categoryModel.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: categoryModel.title,
        ),
      ),
    );
    notifyListeners();
  }

  // select which screen will be displayed after press the drawer items
  void onSelectScreen(String identifier, context) async {
    if (identifier == 'filter') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
      selectedFilters = result ?? kInitialFilters;
    }
  }

// add a meal to the favorite screen
  void toggleMealFavoriteStatus(MealModel meal) {
    final mealIsFavorite = favoritesMeals.contains(meal);
    if (mealIsFavorite) {
      favoritesMeals.remove(meal);
    } else {
      favoritesMeals.add(meal);
    }
  }
}
