import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';

enum Screen { dashboard, list, form, food }

class CrocodileContainer extends StatefulWidget {
  const CrocodileContainer({super.key});

  @override
  State<CrocodileContainer> createState() => _CrocodileContainerState();
}

class _CrocodileContainerState extends State<CrocodileContainer> {
  final List<Crocodile> _crocodiles = [];
  final List<CrocodileFood> _foods = [];
  Screen _currentScreen = Screen.dashboard;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  void _showFood() {
    setState(() => _currentScreen = Screen.food);
  }

  void _showDashboard() {
    setState(() => _currentScreen = Screen.dashboard);
  }

  void _showList() {
    setState(() => _currentScreen = Screen.list);
  }

  void _showForm() {
    setState(() => _currentScreen = Screen.form);
  }

  void _addCrocodile(
    String name,
    String species,
    int age,
    double length,
    double weight,
    CrocodileStatus status,
    String enclosure,
  ) {
    setState(() {
      final newCrocodile = Crocodile(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        species: species,
        age: age,
        length: length,
        weight: weight,
        status: status,
        enclosure: enclosure,
      );
      _crocodiles.add(newCrocodile);
      _currentScreen = Screen.list;
    });
  }

  void _changeStatusCrocodile(String id, CrocodileStatus status) {
    setState(() {
      final index = _crocodiles.indexWhere((c) => c.id == id);
      if (index != -1) {
        final crocodile = _crocodiles[index];
        _crocodiles[index] = crocodile.copyWith(status: status);
      }
    });
  }

  void _deleteCrocodile(String id) {
    final index = _crocodiles.indexWhere((c) => c.id == id);
    if (index == -1) return;
    final removed = _crocodiles.removeAt(index);
    setState(() {});
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Крокодил удален'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => setState(() {
            _crocodiles.insert(index, removed);
          }),
        ),
      ),
    );
  }

  Map<CrocodileStatus, int> _createMapCountStatuses() {
    final result = <CrocodileStatus, int>{};
    for (final crocodile in _crocodiles) {
      result[crocodile.status] = (result[crocodile.status] ?? 0) + 1;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case Screen.dashboard:
        return DashboardScreen(
          statusCounts: _createMapCountStatuses(),
          onList: _showList,
          onFood: _showFood,
        );
      case Screen.list:
        return CrocodilesListScreen(
          crocodiles: _crocodiles,
          onAdd: _showForm,
          onDashboard: _showDashboard,
          onChangeStatus: (id, status) => _changeStatusCrocodile(id, status),
          onDelete: (id) => _deleteCrocodile(id),
        );
      case Screen.form:
        return CrocodileFormScreen(onSave: _addCrocodile, onCancel: _showList);
      case Screen.food:
        return CrocodileFoodScreen(foods: _foods, onBack: _showDashboard);
    }
  }

  String _getCrocodileImageUrl(String crocodileId) {
    return 'https://example.com/crocodile-$crocodileId.jpg';
  }

  void _initializeSampleData() {
    // Sample foods
    _foods.addAll([
      CrocodileFood(
        id: '1',
        name: 'Свежая рыба',
        type: 'Рыба',
        quantity: 5.0,
        unit: 'кг',
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=df4a18595c421c504a675fa50594c62e_l-5161002-images-thumbs&n=13',
      ),
      CrocodileFood(
        id: '2',
        name: 'Куриное мясо',
        type: 'Мясо',
        quantity: 3.0,
        unit: 'кг',
        imageUrl:
            'https://image.made-in-china.com/2f0j00sgpkeIcKhtuq/High-Quality-China-Frozen-Whole-Duck-by-Hand-Slaughter-with-Halal-Certificate.webp',
      ),
    ]);
  }
}
