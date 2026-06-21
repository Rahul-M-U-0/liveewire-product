import 'package:flutter_test/flutter_test.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/di/di.dart' as di;
import 'package:liveewire_products/features/product/data/datasources/product_remote_datasource.dart';
import 'package:liveewire_products/features/product/data/models/category_model.dart';
import 'package:liveewire_products/features/product/data/models/paginated_products_model.dart';
import 'package:liveewire_products/features/product/data/models/product_model.dart';
import 'package:liveewire_products/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeProductRemoteDataSource implements ProductRemoteDataSource {
  @override
  Future<PaginatedProductsModel> getProducts({
    required int limit,
    required int skip,
    String? category,
    String? query,
  }) async {
    return const PaginatedProductsModel(
      products: [],
      total: 0,
      skip: 0,
      limit: 10,
    );
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return [];
  }
}

void main() {
  testWidgets('App boot-up and Splash screen smoke test', (
    WidgetTester tester,
  ) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Initialize DI first
    await di.init();

    // Override the registered ProductRemoteDataSource with our Fake
    di.sl.allowReassignment = true;
    di.sl.registerLazySingleton<ProductRemoteDataSource>(
      () => FakeProductRemoteDataSource(),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash page is displayed with the title.
    expect(find.text(AppStrings.splashLogoTitle), findsOneWidget);

    // Drain the navigation timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
