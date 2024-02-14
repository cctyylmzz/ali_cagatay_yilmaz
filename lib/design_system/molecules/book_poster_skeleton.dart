import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class BookPosterSkeleton extends StatelessWidget {
  const BookPosterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonAvatar(
      style: SkeletonAvatarStyle(width: 96, height: 136),
    );
  }
}
