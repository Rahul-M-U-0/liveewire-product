import 'package:go_router/go_router.dart';
import 'package:liveewire_products/features/splash/presentation/pages/splash_page.dart';
import 'package:liveewire_products/features/product/presentation/pages/product_list_page.dart';
import 'package:liveewire_products/features/product/presentation/pages/product_detail_page.dart';
import 'package:liveewire_products/features/cart/presentation/pages/cart_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: SplashPage.routePath,
  routes: [
    GoRoute(
      name: SplashPage.routeName,
      path: SplashPage.routePath,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: ProductListPage.routeName,
      path: ProductListPage.routePath,
      builder: (context, state) => const ProductListPage(),
    ),
    GoRoute(
      name: ProductDetailPage.routeName,
      path: ProductDetailPage.routePath,
      builder: (context, state) {
        final idStr = state.pathParameters['id']!;
        final id = int.parse(idStr);
        return ProductDetailPage(productId: id);
      },
    ),
    GoRoute(
      name: CartPage.routeName,
      path: CartPage.routePath,
      builder: (context, state) => const CartPage(),
    ),
  ],
);
