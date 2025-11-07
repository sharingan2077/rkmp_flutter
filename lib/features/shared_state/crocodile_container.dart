import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/models/crocodile_image_urls.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/features/habitats/screens/crocodile_habitat_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';

class CrocodileContainer extends StatefulWidget {
  const CrocodileContainer({super.key});

  @override
  State<CrocodileContainer> createState() => _CrocodileContainerState();
}

class _CrocodileContainerState extends State<CrocodileContainer> {
  final List<Crocodile> _crocodiles = [];
  final List<CrocodileFood> _foods = [];
  final List<CrocodileHabitat> _habitats = [];

  // Убираем индекс текущей вкладки, так как навигация будет через кнопки
  Widget? _currentScreen;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
    // Начинаем с главного экрана
    _currentScreen = DashboardScreen(
      statusCounts: _createMapCountStatuses(),
      onFood: _showFoodScreen,
      onCrocodiles: _showCrocodilesList,
      onHabitats: _showHabitats,
    );
  }

  void _initializeSampleData() {
    _crocodiles.addAll([
      Crocodile(
        id: '1',
        name: 'Гена',
        species: 'Нильский крокодил',
        age: 15,
        length: 4.2,
        weight: 450.0,
        status: CrocodileStatus.healthy,
        enclosure: 'Тропический вольер A',
      ),
      Crocodile(
        id: '2',
        name: 'Клава',
        species: 'Гребнистый крокодил',
        age: 12,
        length: 3.8,
        weight: 380.0,
        status: CrocodileStatus.needCheckup,
        enclosure: 'Речной биотоп B',
      ),
    ]);

    _foods.addAll([
      CrocodileFood(
        id: '1',
        name: 'Свежая рыба',
        type: 'Рыба',
        quantity: 5.0,
        unit: 'кг',
        imageUrl: 'https://avatars.mds.yandex.net/i?id=df4a18595c421c504a675fa50594c62e_l-5161002-images-thumbs&n=13',
      ),
      CrocodileFood(
        id: '2',
        name: 'Куриное мясо',
        type: 'Мясо',
        quantity: 3.0,
        unit: 'кг',
        imageUrl: 'https://image.made-in-china.com/2f0j00sgpkeIcKhtuq/High-Quality-China-Frozen-Whole-Duck-by-Hand-Slaughter-with-Halal-Certificate.webp',
      ),
    ]);

    _habitats.addAll([
      CrocodileHabitat(
        id: '1',
        name: 'Тропический вольер',
        description: 'Просторный вольер с тропической растительностью и бассейном, имитирующий естественную среду обитания нильских крокодилов',
        temperature: 28.5,
        humidity: 80.0,
        imageUrl: 'https://images.squarespace-cdn.com/content/v1/568d1cc02399a30df6221280/1528884890037-76N8U4Z58BLB5XJL2NRM/Wildlands_Jungola_JoraVision+3.jpg',
      ),
      CrocodileHabitat(
        id: '2',
        name: 'Речной биотоп',
        description: 'Имитация речной среды с проточной водой и каменистыми берегами, идеальная для гребнистых крокодилов',
        temperature: 26.0,
        humidity: 75.0,
        imageUrl: 'https://i.pinimg.com/originals/d1/f0/a0/d1f0a01c7fdf1e23f5c926a2ccce4ad6.jpg',
      ),
    ]);
  }

  // Горизонтальная навигация - переход к списку крокодилов
  void _showCrocodilesList() {
    setState(() {
      _currentScreen = CrocodilesListScreen(
        crocodiles: _crocodiles,
        onAdd: _showForm,
        onChangeStatus: _changeStatusCrocodile,
        onDelete: _deleteCrocodile,
        imageUrl: _getCrocodileListImageUrl(),
        onBack: _goToDashboard, // Кнопка назад ведет на главный экран
      );
    });
  }

  // Горизонтальная навигация - переход к средам обитания
  void _showHabitats() {
    setState(() {
      _currentScreen = CrocodileHabitatScreen(
        habitats: _habitats,
        onBack: _goToDashboard, // Кнопка назад ведет на главный экран
      );
    });
  }

  // Вертикальная навигация - переход к форме добавления крокодила
  void _showForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrocodileFormScreen(
          onSave: _addCrocodile,
          onCancel: _goBack,
          imageUrl: _getCrocodileFormImageUrl(),
        ),
      ),
    );
  }

  // Вертикальная навигация - переход к питанию
  void _showFoodScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrocodileFoodScreen(
          foods: _foods,
          onBack: _goBack,
        ),
      ),
    );
  }

  // Возврат на предыдущий экран (вертикальная навигация)
  void _goBack() {
    Navigator.pop(context);
  }

  // Возврат на главный экран (горизонтальная навигация)
  void _goToDashboard() {
    setState(() {
      _currentScreen = DashboardScreen(
        statusCounts: _createMapCountStatuses(),
        onFood: _showFoodScreen,
        onCrocodiles: _showCrocodilesList,
        onHabitats: _showHabitats,
      );
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
        content: Text('Крокодил ${removed.name} удален'),
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
    });
    _goBack();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen ?? DashboardScreen(
        statusCounts: _createMapCountStatuses(),
        onFood: _showFoodScreen,
        onCrocodiles: _showCrocodilesList,
        onHabitats: _showHabitats,
      ),
    );
  }
}