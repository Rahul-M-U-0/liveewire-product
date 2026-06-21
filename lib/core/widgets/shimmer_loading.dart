import 'package:flutter/material.dart';
import 'package:liveewire_products/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase(context),
      highlightColor: AppColors.shimmerHighlight(context),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 8),
            child: ShimmerContainer(
              width: 90,
              height: 36,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          );
        },
      ),
    );
  }
}

class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: ShimmerContainer(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerContainer(width: 50, height: 8),
                          SizedBox(height: 4),
                          ShimmerContainer(width: 100, height: 12),
                          SizedBox(height: 6),
                          ShimmerContainer(width: 70, height: 10),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerContainer(width: 60, height: 14),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerContainer(
            width: double.infinity,
            height: 300,
            borderRadius: BorderRadius.zero,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(
                      width: 80,
                      height: 24,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    ShimmerContainer(width: 60, height: 16),
                  ],
                ),
                SizedBox(height: 16),
                ShimmerContainer(width: 250, height: 24),
                SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerContainer(width: 40, height: 16),
                    SizedBox(width: 16),
                    ShimmerContainer(
                      width: 100,
                      height: 24,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ShimmerContainer(width: 120, height: 20),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: ShimmerContainer(width: double.infinity, height: 44, borderRadius: BorderRadius.all(Radius.circular(12)))),
                    SizedBox(width: 12),
                    Expanded(child: ShimmerContainer(width: double.infinity, height: 44, borderRadius: BorderRadius.all(Radius.circular(12)))),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: ShimmerContainer(width: double.infinity, height: 44, borderRadius: BorderRadius.all(Radius.circular(12)))),
                    SizedBox(width: 12),
                    Expanded(child: ShimmerContainer(width: double.infinity, height: 44, borderRadius: BorderRadius.all(Radius.circular(12)))),
                  ],
                ),
                SizedBox(height: 24),
                ShimmerContainer(width: 120, height: 20),
                SizedBox(height: 12),
                ShimmerContainer(width: double.infinity, height: 14),
                SizedBox(height: 6),
                ShimmerContainer(width: double.infinity, height: 14),
                SizedBox(height: 6),
                ShimmerContainer(width: 200, height: 14),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
