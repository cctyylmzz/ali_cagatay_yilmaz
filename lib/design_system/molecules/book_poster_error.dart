import 'package:flutter/material.dart';

class BookPosterError extends StatelessWidget {
  const BookPosterError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 136,
      decoration: const BoxDecoration(color: Colors.grey),
      child: const Center(child: Icon(Icons.book, color: Colors.white)),
    );
  }
}
