import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      padding: const EdgeInsets.all(16),

      height: 150,

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

            offset: const Offset(0, 5),

            color: Colors.black.withValues(alpha: 0.15),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  '🔥 Special Offer',

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: 17,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Discover amazing products\nwith best prices',

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 34,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      backgroundColor: Colors.white,

                      foregroundColor: Colors.black,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: const Text(
                      'Shop Now',

                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          const Icon(
            Icons.shopping_bag_outlined,

            size: 55,

            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
