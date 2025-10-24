import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_image_urls.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/features/habitats/screens/crocodile_habitat_screen.dart';

enum Screen { dashboard, list, form, food, habitat }

class CrocodileContainer extends StatefulWidget {
  const CrocodileContainer({super.key});

  @override
  State<CrocodileContainer> createState() => _CrocodileContainerState();
}

class _CrocodileContainerState extends State<CrocodileContainer> {
  final List<Crocodile> _crocodiles = [];
  final List<CrocodileFood> _foods = [];
  final List<CrocodileHabitat> _habitats = [];
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

  void _showHabitat() => setState(() => _currentScreen = Screen.habitat);

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
          onHabitat: _showHabitat,
        );
      case Screen.list:
        return CrocodilesListScreen(
          crocodiles: _crocodiles,
          onAdd: _showForm,
          onDashboard: _showDashboard,
          onChangeStatus: (id, status) => _changeStatusCrocodile(id, status),
          onDelete: (id) => _deleteCrocodile(id),
          imageUrl: _getCrocodileListImageUrl(),
        );
      case Screen.form:
        return CrocodileFormScreen(onSave: _addCrocodile, onCancel: _showList, imageUrl: _getCrocodileFormImageUrl(),);
      case Screen.food:
        return CrocodileFoodScreen(foods: _foods, onBack: _showDashboard);
      case Screen.habitat:
        return CrocodileHabitatScreen(
          habitats: _habitats,
          onBack: _showDashboard,
        );
    }
  }

  String _getCrocodileImageUrl(String crocodileId) {
    return CrocodileImageUrls.getCrocodileImage(crocodileId);
  }
  String _getCrocodileListImageUrl() {
    return CrocodileImageUrls.getCrocodileListImage();
  }
  String _getCrocodileFormImageUrl() {
    return CrocodileImageUrls.getCrocodileFormImage();
  }

  void _initializeSampleData() {
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

    _habitats.addAll([
      CrocodileHabitat(
        id: '1',
        name: 'Тропический вольер',
        description: 'Просторный вольер с тропической растительностью и бассейном',
        temperature: 28.5,
        humidity: 80.0,
        imageUrl: 'https://images.squarespace-cdn.com/content/v1/568d1cc02399a30df6221280/1528884890037-76N8U4Z58BLB5XJL2NRM/Wildlands_Jungola_JoraVision+3.jpg',
      ),
      CrocodileHabitat(
        id: '2',
        name: 'Речной биотоп',
        description: 'Имитация речной среды с проточной водой',
        temperature: 26.0,
        humidity: 75.0,
        imageUrl: 'https://i.pinimg.com/originals/d1/f0/a0/d1f0a01c7fdf1e23f5c926a2ccce4ad6.jpg',
      ),
    ]);

  }
}
