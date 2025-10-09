import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/crocodiles/screens/dashboard_screen.dart';

enum Screen { dashboard, list, form }

class CrocodileContainer extends StatefulWidget {
  const CrocodileContainer({super.key});

  @override
  State<CrocodileContainer> createState() => _CrocodileContainerState();
}

class _CrocodileContainerState extends State<CrocodileContainer> {
  final List<Crocodile> _crocodiles = [];
  Screen _currentScreen = Screen.dashboard;

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
    setState(() {
      _crocodiles.removeWhere((c) => c.id == id);
    });
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
        );
      case Screen.list:
        return CrocodilesListScreen(
          crocodiles: _crocodiles,
          onAdd: _showForm,
          onChangeStatus: (id, status) => _changeStatusCrocodile(id, status),
          onDelete: (id) => _deleteCrocodile(id),
        );
      case Screen.form:
        return CrocodileFormScreen(onSave: _addCrocodile, onCancel: _showList);
    }
  }
}
