import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pedidos_app/core/constants/app_colors.dart';
import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';
import 'package:pedidos_app/data/repositories/order_repository_impl.dart';
import 'package:pedidos_app/data/datasources/order_remote_datasource.dart';
import 'package:pedidos_app/presentation/screens/orders_screen.dart';
import 'package:pedidos_app/presentation/screens/order_detail_screen.dart';
import 'package:pedidos_app/presentation/screens/create_order_screen.dart';
import 'package:pedidos_app/presentation/viewmodels/orders_viewmodel.dart';

final GetIt getIt = GetIt.instance;

Future<void> _setupDependencies() async {
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient('https://api.pedidos.example.com/prod'),
  );

  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt<OrderRemoteDataSource>()),
  );

  getIt.registerFactory<OrdersViewModel>(
    () => OrdersViewModel(getIt<OrderRepository>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupDependencies();
  runApp(const PedidosApp());
}

class PedidosApp extends StatelessWidget {
  const PedidosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrdersViewModel>(),
      child: MaterialApp(
        title: 'Pedidos App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            color: AppColors.surface,
            elevation: AppColors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.onSecondary,
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => const OrdersScreen(),
              );
            case '/order-detail':
              final orderId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => OrderDetailScreen(orderId: orderId),
              );
            case '/create-order':
              return MaterialPageRoute(
                builder: (_) => const CreateOrderScreen(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const OrdersScreen(),
              );
          }
        },
      ),
    );
  }
}