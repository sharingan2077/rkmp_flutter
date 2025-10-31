import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';

class CrocodileProvider extends ChangeNotifier {
  final List<Crocodile> _crocodiles = [];
  final List<CrocodileFood> _foods = [];
  final List<CrocodileHabitat> _habitats = [];

  List<Crocodile> get crocodiles => _crocodiles;
  List<CrocodileFood> get foods => _foods;
  List<CrocodileHabitat> get habitats => _habitats;

  CrocodileProvider() {
    _initializeSampleData();
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

    // Initialize foods
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

    // Initialize habitats
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

  void addCrocodile(
      String name,
      String species,
      int age,
      double length,
      double weight,
      CrocodileStatus status,
      String enclosure,
      ) {
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
    notifyListeners();
  }

  void changeStatus(String id, CrocodileStatus status) {
    final index = _crocodiles.indexWhere((c) => c.id == id);
    if (index != -1) {
      final crocodile = _crocodiles[index];
      _crocodiles[index] = crocodile.copyWith(status: status);
      notifyListeners();
    }
  }

  void deleteCrocodile(String id) {
    final index = _crocodiles.indexWhere((c) => c.id == id);
    if (index != -1) {
      _crocodiles.removeAt(index);
      notifyListeners();
    }
  }

  Map<CrocodileStatus, int> getStatusCounts() {
    final result = <CrocodileStatus, int>{};
    for (final crocodile in _crocodiles) {
      result[crocodile.status] = (result[crocodile.status] ?? 0) + 1;
    }
    return result;
  }
}