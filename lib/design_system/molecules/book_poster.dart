import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'book_poster_error.dart';
import 'book_poster_skeleton.dart';

class BookPoster extends StatelessWidget {
  final String image;
  const BookPoster({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 92,
      height: 136,
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const BookPosterSkeleton(),
      errorWidget: (context, url, error) => const BookPosterError(),
    );
  }
}
