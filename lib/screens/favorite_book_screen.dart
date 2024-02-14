import 'package:ali_cagatay_yilmaz/design_system/organisms/book_card_error.dart';
import 'package:flutter/material.dart';

import '../api/database_service.dart';
import '../design_system/organisms/book_card.dart';
import '../design_system/organisms/book_card_skeleton.dart';
import '../models/favorite_book.dart';

class FavoriteBookScreen extends StatefulWidget {
  const FavoriteBookScreen({super.key});

  @override
  State<FavoriteBookScreen> createState() => _FavoriteBookScreenState();
}

class _FavoriteBookScreenState extends State<FavoriteBookScreen> {
  final dbService = DatabaseService();

  void deleteFavoriteBook(String id) {
    dbService.deleteFavoriteBook(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: Text(
              'Favoriler',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FutureBuilder<List<FavoriteBook>>(
            future: dbService.getFavoriteBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) =>
                            const BookCardSkeleton(),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const SliverFillRemaining(child: BookCardError());
                }
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => BookCard(
                          isFavorite: true,
                          image: snapshot.data![index].image,
                          title: snapshot.data![index].title,
                          subtitle: snapshot.data![index].subTitle,
                          authors: snapshot.data![index].authors!,
                          publisher: snapshot.data![index].publisher,
                          pageCount: snapshot.data![index].pageCount,
                          publishedDate: snapshot.data![index].publishedDate,
                          onDoubleTap: () {},
                          onLongPressed: () {
                            deleteFavoriteBook(snapshot.data![index].id);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SliverFillRemaining(child: BookCardError());
            },
          ),
        ],
      ),
    );
  }
}
