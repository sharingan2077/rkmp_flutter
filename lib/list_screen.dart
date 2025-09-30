import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  static const Map<String, int> _countryPopulation = {
    'Китай': 1441,
    'Индия': 1393,
    'США': 332,
    'Индонезия': 276,
    'Пакистан': 241,
    'Бразилия': 214,
    'Нигерия': 223,
    'Бангладеш': 169,
    'Россия': 144,
    'Мексика': 128,
    'Япония': 125,
    'Эфиопия': 123,
    'Филиппины': 112,
    'Египет': 109,
    'Вьетнам': 98,
    'ДР Конго': 102,
    'Турция': 85,
    'Иран': 85,
    'Германия': 83,
    'Таиланд': 70,
  };

  List<Widget> generateListItems() =>
      _countryPopulation.entries.map((entry) =>
          createListItem(entry.key, entry.value)).toList();


  Widget createListItem(String title, int population) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Text(
              "Население страны $title:",
              style: TextStyle(color: Colors.purple, fontSize: 16),
              overflow: TextOverflow.ellipsis, // текст не вылезет за границы
            ),
          ),
          Text(
            "$population млн",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: generateListItems());
  }}
