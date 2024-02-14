import 'package:flutter/material.dart';
import '../molecules/book_poster.dart';
import '../molecules/book_poster_error.dart';

class BookCard extends StatelessWidget {
  final bool isFavorite;
  final String? image;
  final String? title;
  final String? subtitle;
  final String? authors;
  final String? publisher;
  final int? pageCount;
  final String? publishedDate;
  final Function onDoubleTap;
  final Function onLongPressed;

  const BookCard({
    super.key,
    this.isFavorite = false,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publisher,
    required this.pageCount,
    required this.publishedDate,
    required this.onDoubleTap,
    required this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        onDoubleTap();
      },
      onLongPress: () {
        onLongPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: isFavorite ? Colors.red : Colors.blue),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image != null
                ? BookPoster(image: image ?? '')
                : const BookPosterError(),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Bilinmiyor',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: Colors.grey, thickness: 0.2, height: 0),
                  Visibility(
                    visible: subtitle != null,
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          subtitle ?? '',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: authors != null,
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Authors: ${authors ?? ''}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: publisher != null,
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Publisher: ${publisher ?? ''}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: pageCount != null && pageCount != 0,
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Page: ${pageCount ?? ''}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: publishedDate != null,
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Published at: ${publishedDate ?? ''}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
