import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/di/di.dart' as di;
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/router/app_router.dart';
import 'package:liveewire_products/core/theme/app_theme.dart';
import 'package:liveewire_products/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (_) => di.sl<ProductBloc>()),
        BlocProvider<CategoryBloc>(create: (_) => di.sl<CategoryBloc>()),
        BlocProvider<CartBloc>(
          create: (_) => di.sl<CartBloc>()..add(LoadCartEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
