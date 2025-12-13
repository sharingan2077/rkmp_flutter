import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../widgets/logout_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<AuthCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Крокодилий заповедник'),
          backgroundColor: Colors.green[700],
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                locator<AuthCubit>().logout();
                context.go('/login');
              },
              tooltip: 'Выйти',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Верхнее изображение - ОПТИМИЗИРОВАННОЕ
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final bannerHeight = screenWidth > 600 ? 180.0 : 120.0; // Увеличили высоту

                  return Container(
                    height: bannerHeight,
                    width: double.infinity,
                    color: Colors.green[50], // Фон на случай если изображение не загрузится
                    child: Stack(
                      children: [
                        // Изображение с fit: BoxFit.contain (сохраняет пропорции)
                        CachedNetworkImage(
                          imageUrl: 'https://i.pinimg.com/originals/0f/11/02/0f1102409783f9f98a3551e198851687.png?nii=t',
                          fit: BoxFit.contain, // Меняем cover на contain
                          placeholder: (context, url) => Container(
                            color: Colors.green[100],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.nature, color: Colors.green, size: 50),
                            ),
                          ),
                        ),

                        // Градиент для лучшей читаемости текста если он будет
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.green[800]!.withOpacity(0.3),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.green[800]!.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Статистика
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: StatsCard(),
              ),

              // Заголовок меню
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.dashboard, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text(
                      'Быстрый доступ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Адаптивная сетка карточек
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  int crossAxisCount;

                  if (screenWidth > 1200) {
                    crossAxisCount = 4;
                  } else if (screenWidth > 800) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount = 2;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                      children: [
                        DashboardCard(
                          title: 'Крокодилы',
                          subtitle: 'Учет особей',
                          icon: Icons.psychology,
                          color: Colors.green,
                          onTap: () => context.push('/crocodiles'),
                        ),
                        DashboardCard(
                          title: 'Питание',
                          subtitle: 'Рацион и запасы',
                          icon: Icons.restaurant,
                          color: Colors.orange,
                          onTap: () => context.push('/food'),
                        ),
                        DashboardCard(
                          title: 'Среда обитания',
                          subtitle: 'Вольеры и условия',
                          icon: Icons.nature,
                          color: Colors.blue,
                          onTap: () => context.push('/habitats'),
                        ),
                        DashboardCard(
                          title: 'Медицина',
                          subtitle: 'Записи и лечение',
                          icon: Icons.medical_services,
                          color: Colors.red,
                          onTap: () => context.push('/medical'),
                        ),
                        DashboardCard(
                          title: 'Посетители',
                          subtitle: 'Учет и билеты',
                          icon: Icons.people,
                          color: Colors.purple,
                          onTap: () => context.push('/visitors'),
                        ),
                        LogoutCard(
                          onLogout: () {
                            locator<AuthCubit>().logout();
                            context.go('/login');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}