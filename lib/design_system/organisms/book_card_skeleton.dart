import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../molecules/book_poster_skeleton.dart';

class BookCardSkeleton extends StatelessWidget {
  const BookCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookPosterSkeleton(),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                SizedBox(height: 6),
                Divider(color: Colors.grey, thickness: 0.2, height: 0),
                SizedBox(height: 6),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 14,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                SizedBox(height: 4),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                SizedBox(height: 4),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                SizedBox(height: 4),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                SizedBox(height: 4),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
