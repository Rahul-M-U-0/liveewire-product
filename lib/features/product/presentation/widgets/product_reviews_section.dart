import 'package:flutter/material.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_rating_stars.dart';

class ProductReviewsSection extends StatelessWidget {
  final ProductEntity product;

  const ProductReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = product.reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppStrings.reviews} (${reviews.length})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (reviews.isNotEmpty)
              Row(
                children: [
                  Icon(Icons.star, color: theme.colorScheme.tertiary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (reviews.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 36,
                    color: theme.colorScheme.outline.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.noReviewsYet,
                    style: TextStyle(
                      color: theme.colorScheme.outline,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => Divider(
              height: 24,
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
            itemBuilder: (context, index) {
              final review = reviews[index];
              final reviewerInitials = review.reviewerName.isNotEmpty
                  ? review.reviewerName
                        .trim()
                        .split(' ')
                        .map((e) => e[0])
                        .take(2)
                        .join()
                        .toUpperCase()
                  : 'A';

              // Parse date cleanly
              String formattedDate = '';
              try {
                final parsedDate = DateTime.parse(review.date);
                formattedDate =
                    '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
              } catch (_) {
                formattedDate = review.date.split('T').first;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          reviewerInitials,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.reviewerName,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: theme.colorScheme.outline,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ProductRatingStars(
                        rating: review.rating.toDouble(),
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 44),
                    child: Text(
                      review.comment,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
