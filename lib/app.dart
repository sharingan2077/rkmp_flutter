import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:project/routes/app_router.dart';
import 'package:project/service_locator.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CrocodileProvider(),
      child: Builder(
        builder: (context) {
          // Инициализируем AppStateService с данными при старте приложения
          final provider = Provider.of<CrocodileProvider>(context, listen: false);
          final statusCounts = provider.getStatusCounts();

          final appStateService = locator.get<AppStateService>();
          appStateService.updateStats(
            totalCrocodiles: provider.crocodiles.length,
            healthyCrocodiles: statusCounts[CrocodileStatus.healthy] ?? 0,
            crocodilesNeedCheckup: statusCounts[CrocodileStatus.needCheckup] ?? 0,
            crocodilesOnTreatment: statusCounts[CrocodileStatus.treatment] ?? 0,
          );

          return MaterialApp.router(
            title: 'Крокодилий заповедник',
            theme: ThemeData(
              primarySwatch: Colors.green,
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}