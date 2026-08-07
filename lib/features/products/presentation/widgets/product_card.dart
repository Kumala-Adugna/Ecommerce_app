import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(16),

      child: Card(
        elevation: 4,

        shadowColor: Colors.black12,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,

                    child: Image.network(
                      product.image,

                      fit: BoxFit.contain,

                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported, size: 40),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    right: 8,
                    top: 8,

                    child: CircleAvatar(
                      radius: 16,

                      backgroundColor: Colors.white,

                      child: Icon(
                        Icons.favorite_border,

                        size: 20,

                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    product.title,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),

                      const SizedBox(width: 4),

                      Text(
                        product.rating.toStringAsFixed(1),

                        style: const TextStyle(fontSize: 13),
                      ),

                      Text(
                        ' (${product.ratingCount})',

                        style: TextStyle(
                          color: Colors.grey.shade600,

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '\$${product.price}',

                    style: const TextStyle(
                      color: Colors.green,

                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
