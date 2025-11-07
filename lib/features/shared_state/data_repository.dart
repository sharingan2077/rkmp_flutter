// features/data/data_repository.dart
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/food/model/crocodile_food.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';

class DataRepository {
  static List<Crocodile> getSampleCrocodiles() {
    return [
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
    ];
  }

  static List<CrocodileFood> getSampleFoods() {
    return [
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
    ];
  }

  static List<CrocodileHabitat> getSampleHabitats() {
    return [
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
    ];
  }
}