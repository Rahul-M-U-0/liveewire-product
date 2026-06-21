import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liveewire_products/core/network/dio_client.dart';
import 'package:liveewire_products/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:liveewire_products/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:liveewire_products/features/cart/domain/repositories/cart_repository.dart';
import 'package:liveewire_products/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:liveewire_products/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:liveewire_products/features/product/data/datasources/product_remote_datasource.dart';
import 'package:liveewire_products/features/product/data/repositories/product_repository_impl.dart';
import 'package:liveewire_products/features/product/domain/repositories/product_repository.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_products_usecase.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_detail_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<DioClient>(DioClient());

  // Features - Product Catalog
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dioClient: sl()),
  );
  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  // Use Cases
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(repository: sl()),
  );
  // Presentation (BLoCs)
  sl.registerFactory<ProductBloc>(() => ProductBloc(getProductsUseCase: sl()));
  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(getCategoriesUseCase: sl()),
  );
  sl.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(getProductDetailsUseCase: sl()),
  );

  // Features - Shopping Cart
  // Data Sources
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );
  // Repositories
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );
  // Use Cases
  sl.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(repository: sl()),
  );
  sl.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteFromCartUseCase>(
    () => DeleteFromCartUseCase(repository: sl()),
  );
  sl.registerLazySingleton<ClearCartUseCase>(
    () => ClearCartUseCase(repository: sl()),
  );
  // Presentation (BLoCs)
  sl.registerFactory<CartBloc>(
    () => CartBloc(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      deleteFromCartUseCase: sl(),
      clearCartUseCase: sl(),
    ),
  );
}
