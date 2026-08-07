import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),

      height: 160,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,

            Theme.of(context).colorScheme.secondary,
          ],
        ),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.15),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    '🔥 Special Offer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Discover amazing products\nwith best prices',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      foregroundColor: Colors.black,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: const Text('Shop Now'),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.shopping_bag_outlined,

              size: 70,

              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
