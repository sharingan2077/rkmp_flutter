// features/visitors/screens/add_visitor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/visitor_cubit.dart';
import '../models/visitor_dart.dart';

class AddVisitorScreen extends StatefulWidget {
  const AddVisitorScreen({super.key});

  @override
  State<AddVisitorScreen> createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ticketCountController = TextEditingController(text: '1');
  final _ticketTypeController = TextEditingController();
  final _totalPriceController = TextEditingController();

  final List<String> _ticketTypes = ['Взрослый', 'Детский', 'Семейный', 'Льготный'];
  String _selectedTicketType = 'Взрослый';
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final ticketCountText = _ticketCountController.text;
    final totalPriceText = _totalPriceController.text;

    final ticketCount = int.tryParse(ticketCountText) ?? 1;
    final totalPrice = double.tryParse(totalPriceText) ?? 0.0;

    final visitor = Visitor(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      visitDate: _selectedDate,
      ticketCount: ticketCount,
      totalPrice: totalPrice,
      ticketType: _selectedTicketType,
    );

    final cubit = locator<VisitorCubit>();
    cubit.addVisitor(visitor);

    // Показываем подтверждение
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Посетитель успешно добавлен'),
        backgroundColor: Colors.green,
      ),
    );

    // Возвращаемся назад
    Future.delayed(const Duration(milliseconds: 500), () {
      context.pop();
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2025, 12, 31),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _calculatePrice() {
    final ticketCount = int.tryParse(_ticketCountController.text) ?? 1;
    double pricePerTicket = 500.0; // Базовая цена

    // Разные цены в зависимости от типа билета
    switch (_selectedTicketType) {
      case 'Детский':
        pricePerTicket = 250.0;
        break;
      case 'Семейный':
        pricePerTicket = 1200.0;
        break;
      case 'Льготный':
        pricePerTicket = 300.0;
        break;
      default:
        pricePerTicket = 500.0;
    }

    final totalPrice = ticketCount * pricePerTicket;
    _totalPriceController.text = totalPrice.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _calculatePrice();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ticketCountController.dispose();
    _ticketTypeController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить посетителя'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ФИО посетителя',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите ФИО посетителя';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Выбор даты
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Дата посещения',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day.toString().padLeft(2, '0')}.'
                            '${_selectedDate.month.toString().padLeft(2, '0')}.'
                            '${_selectedDate.year}',
                      ),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Выбор типа билета
              DropdownButtonFormField<String>(
                value: _selectedTicketType,
                decoration: const InputDecoration(
                  labelText: 'Тип билета',
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
                items: _ticketTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTicketType = newValue!;
                    _calculatePrice();
                  });
                },
              ),
              const SizedBox(height: 16),

              // Количество билетов
              TextFormField(
                controller: _ticketCountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Количество билетов',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _calculatePrice();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите количество билетов';
                  }
                  final count = int.tryParse(value);
                  if (count == null || count <= 0) {
                    return 'Введите корректное количество';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Итоговая сумма (вычисляется автоматически)
              TextFormField(
                controller: _totalPriceController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Итоговая сумма',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),

              // Информация о ценах
              Card(
                color: Colors.blue.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Стоимость билетов:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('• Взрослый: 500 ₽'),
                      Text('• Детский: 250 ₽'),
                      Text('• Семейный (до 4 чел.): 1200 ₽'),
                      Text('• Льготный: 300 ₽'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Кнопка добавления
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Добавить посетителя',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}