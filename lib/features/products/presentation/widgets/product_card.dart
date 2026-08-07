import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(20),

      child: Card(
        elevation: 4,

        shadowColor: Colors.black26,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(12),

                    child: Hero(
                      tag: product.id,

                      child: CachedNetworkImage(
                        imageUrl: product.image,

                        fit: BoxFit.contain,

                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },

                        errorWidget: (context, url, error) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.orange,

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.white),

                          const SizedBox(width: 3),

                          Text(
                            product.rating.toString(),

                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 5,
                    left: 5,

                    child: IconButton(
                      onPressed: () {},

                      icon: const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),

              child: Text(
                product.title,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),

              child: Text(
                '\$${product.price}',

                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
