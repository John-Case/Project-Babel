import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/category.dart';

const availableCategories = [
  Category(id: 'c1', title: 'Italian', color: Colors.purple),
  Category(id: 'c2', title: 'Quick & Easy', color: Colors.red),
  Category(id: 'c3', title: 'Hamburgers', color: Colors.orange),
  Category(id: 'c4', title: 'German', color: Colors.amber),
  Category(id: 'c5', title: 'Light & Lovely', color: Colors.blue),
  Category(id: 'c6', title: 'Exotic', color: Colors.green),
  Category(id: 'c7', title: 'Breakfast', color: Colors.lightBlue),
  Category(id: 'c8', title: 'Asian', color: Colors.lightGreen),
  Category(id: 'c9', title: 'French', color: Colors.pink),
  Category(id: 'c10', title: 'Summer', color: Colors.teal),
];

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key, required this.onAddMeal});

  final void Function(Meal newMeal) onAddMeal;

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  String? _selectedCategoryId;
  bool _isExpandedTitle = false;
  bool _isExpandedIngredients = false;
  bool _isExpandedSteps = false;

  void _submitMeal() {
  if (_formKey.currentState!.validate()) {
    final newMeal = Meal(
      id: DateTime.now().toString(),
      categories: [_selectedCategoryId ?? 'c1'],
      title: _titleController.text,
      imageUrl: 'https://thumbs.dreamstime.com/b/food-plate-14996394.jpg',
      ingredients: _ingredientsController.text.split('\n'),
      steps: _stepsController.text.split('\n'),
      duration: 30,
      complexity: Complexity.simple,
      affordability: Affordability.affordable,
      isGlutenFree: _isGlutenFree,
      isLactoseFree: _isLactoseFree,
      isVegan: _isVegan,
      isVegetarian: _isVegetarian,
    );

    widget.onAddMeal(newMeal);
    Navigator.of(context).pop();
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Meal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitMeal, // Call submit function
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCategoryDropdown(),
                const SizedBox(height: 10),
                _buildCollapsibleSection(
                  title: 'Title',
                  controller: _titleController,
                  isExpanded: _isExpandedTitle,
                  onToggle: () => setState(() => _isExpandedTitle = !_isExpandedTitle),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildCollapsibleSection(
                  title: 'Ingredients',
                  controller: _ingredientsController,
                  isExpanded: _isExpandedIngredients,
                  onToggle: () => setState(() => _isExpandedIngredients = !_isExpandedIngredients),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one ingredient';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildCollapsibleSection(
                  title: 'Steps',
                  controller: _stepsController,
                  isExpanded: _isExpandedSteps,
                  onToggle: () => setState(() => _isExpandedSteps = !_isExpandedSteps),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one step';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildToggleSwitch('Gluten-Free', _isGlutenFree, (newValue) {
                  setState(() => _isGlutenFree = newValue);
                }),
                _buildToggleSwitch('Lactose-Free', _isLactoseFree, (newValue) {
                  setState(() => _isLactoseFree = newValue);
                }),
                _buildToggleSwitch('Vegan', _isVegan, (newValue) {
                  setState(() => _isVegan = newValue);
                }),
                _buildToggleSwitch('Vegetarian', _isVegetarian, (newValue) {
                  setState(() => _isVegetarian = newValue);
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitMeal,
                  child: const Text('Add Meal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
  return DropdownButtonFormField<String>(
    value: _selectedCategoryId,
    decoration: const InputDecoration(
      labelText: 'Category',
      filled: true,
      fillColor: Colors.white, // Make sure the fill color is white
    ),
    dropdownColor: Colors.white, // Set dropdown background color to white
    items: availableCategories.map((category) {
      return DropdownMenuItem<String>(
        value: category.id,
        child: Text(
          category.title,
          style: const TextStyle(color: Colors.black), // Change to black text for contrast
        ),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        _selectedCategoryId = value;
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a category';
      }
      return null;
    },
  );
}

  Widget _buildCollapsibleSection({
    required String title,
    required TextEditingController controller,
    required bool isExpanded,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: onToggle,
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter $title...',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(color: Colors.black),
                validator: validator,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch(String title, bool currentValue, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
