import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/models/crocodile_image_urls.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/features/habitats/screens/crocodile_habitat_screen.dart';
import 'package:project/features/login/screens/LoginScreen.dart';
import 'package:project/features/shared_state/data_repository.dart'; // Импортируем репозиторий

class CrocodileContainer extends StatefulWidget {
  const CrocodileContainer({super.key});

  @override
  State<CrocodileContainer> createState() => _CrocodileContainerState();
}

class _CrocodileContainerState extends State<CrocodileContainer> {
  final List<Crocodile> _crocodiles = [];
  final List<CrocodileFood> _foods = [];
  final List<CrocodileHabitat> _habitats = [];

  Widget? _currentScreen;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
    _currentScreen = DashboardScreen(
      statusCounts: _createMapCountStatuses(),
      onFood: _showFoodScreen,
      onCrocodiles: _showCrocodilesList,
      onHabitats: _showHabitats,
      onLogout: _logout, // Добавляем обработчик выхода
    );
  }

  void _initializeSampleData() {
    // Используем репозиторий для заполнения данных
    _crocodiles.addAll(DataRepository.getSampleCrocodiles());
    _foods.addAll(DataRepository.getSampleFoods());
    _habitats.addAll(DataRepository.getSampleHabitats());
  }

  // Горизонтальная навигация - выход в LoginScreen
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  // // Горизонтальная навигация - переход к списку крокодилов
  // void _showCrocodilesList() {
  //   setState(() {
  //     _currentScreen = CrocodilesListScreen(
  //       crocodiles: _crocodiles,
  //       onAdd: _showForm,
  //       onChangeStatus: _changeStatusCrocodile,
  //       onDelete: _deleteCrocodile,
  //       imageUrl: _getCrocodileListImageUrl(),
  //       onBack: _goToDashboard,
  //     );
  //   });
  // }

  // Горизонтальная навигация - переход к средам обитания
  // void _showHabitats() {
  //   setState(() {
  //     _currentScreen = CrocodileHabitatScreen(
  //       habitats: _habitats,
  //       onBack: _goToDashboard,
  //     );
  //   });
  // }

  void _showHabitats() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrocodileHabitatScreen(
          habitats: _habitats,
          onBack: _goToDashboard,
        ),
      ),
    );
  }

  void _showCrocodilesList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrocodilesListScreen(
          crocodiles: _crocodiles,
          onAdd: _showForm,
          onChangeStatus: _changeStatusCrocodile,
          onDelete: _deleteCrocodile,
          imageUrl: _getCrocodileListImageUrl(),
          onBack: _goToDashboard,
        ),
      ),
    );
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
        onLogout: _logout, // Передаем функцию выхода
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
        onLogout: _logout,
      ),
    );
  }
}