import 'package:flutter/material.dart';
/*
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';
*/

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    //required this.availableMeals,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        gridDelegate: 
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          ),
          children: const[
            Text('1', style: TextStyle(color: Colors.white)),
            Text('2', style: TextStyle(color: Colors.white)),
            Text('3', style: TextStyle(color: Colors.white)),
            Text('4', style: TextStyle(color: Colors.white)),
            Text('5', style: TextStyle(color: Colors.white)),
            Text('6', style: TextStyle(color: Colors.white)),
          ],
        )
      );
  }
}
