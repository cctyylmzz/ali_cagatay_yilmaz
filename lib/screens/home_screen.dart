import 'package:ali_cagatay_yilmaz/cubits/book_cubit.dart';
import 'package:ali_cagatay_yilmaz/screens/favorite_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/database_service.dart';
import '../design_system/atoms/b_elevated_button.dart';
import '../design_system/atoms/b_text_form_field.dart';
import '../design_system/organisms/book_card.dart';
import '../design_system/organisms/book_card_error.dart';
import '../design_system/organisms/book_card_skeleton.dart';
import '../models/book.dart';
import '../models/favorite_book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbService = DatabaseService();

  final TextEditingController _searchController = TextEditingController();
  List<FavoriteBook> favoriteBooks = [];

  @override
  void initState() {
    getFavoriteBooks();
    super.initState();
  }

  Future<void> getFavoriteBooks() async {
    favoriteBooks = await dbService.getFavoriteBooks();
  }

  void searchBook() {
    if (_searchController.text != '') {
      if (_searchController.text.length > 500) {
        const snackBar = SnackBar(
          content: Text(
            'Arama kelimesi geçersizdir.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        context.read<BookCubit>().searchKey = _searchController.text;
        context.read<BookCubit>().searchBook();
        setState(() {});
      }
    }
  }

  void addBookToFavorite(Item item) {
    var favoriteBook = FavoriteBook(
      id: item.id!,
      image: item.volumeInfo!.imageLinks?.thumbnail!,
      title: item.volumeInfo!.title,
      subTitle: item.volumeInfo!.subtitle,
      authors: item.volumeInfo!.authors!.join(', '),
      publisher: item.volumeInfo!.publisher,
      pageCount: item.volumeInfo!.pageCount,
      publishedDate: item.volumeInfo!.publishedDate,
    );
    dbService.insertFavoriteBook(favoriteBook).whenComplete(() => setState(() {
          getFavoriteBooks();
        }));
  }

  void deleteFavoriteBook(String id) {
    dbService.deleteFavoriteBook(id).whenComplete(() => setState(() {
          getFavoriteBooks();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: const Text(
                'Favori Kitaplarım',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (context) => const FavoriteBookScreen()),
                        )
                        .whenComplete(
                          () => setState(() {
                            getFavoriteBooks();
                          }),
                        );
                  },
                ),
              ],
              bottom: AppBar(
                title: SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: BTextFormField(
                          textEditingController: _searchController,
                          prefixIcon: Icons.search,
                        ),
                      ),
                      const SizedBox(width: 12),
                      BElevatedButton(
                        text: 'Search',
                        onPressed: () {
                          searchBook();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                if (state is BookSuccess) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.response.items!.length,
                            itemBuilder: (context, index) {
                              bool isFavorite = false;
                              for (var i = 0; i < favoriteBooks.length; i++) {
                                if (favoriteBooks[i].id ==
                                    state.response.items![index].id) {
                                  isFavorite = true;
                                }
                              }
                              return BookCard(
                                isFavorite: isFavorite,
                                image: state.response.items![index].volumeInfo!
                                    .imageLinks?.thumbnail!,
                                title: state
                                    .response.items![index].volumeInfo!.title,
                                subtitle: state.response.items![index]
                                    .volumeInfo!.subtitle,
                                authors: state
                                    .response.items![index].volumeInfo!.authors!
                                    .join(', '),
                                publisher: state.response.items![index]
                                    .volumeInfo!.publisher,
                                pageCount: state.response.items![index]
                                    .volumeInfo!.pageCount,
                                publishedDate: state.response.items![index]
                                    .volumeInfo!.publishedDate,
                                onDoubleTap: () {
                                  if (!isFavorite) {
                                    addBookToFavorite(
                                        state.response.items![index]);
                                  }
                                },
                                onLongPressed: () {
                                  if (isFavorite) {
                                    deleteFavoriteBook(
                                        state.response.items![index].id!);
                                  }
                                },
                              );
                            }),
                      ],
                    ),
                  );
                } else if (state is BookLoading) {
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
                return const SliverFillRemaining(child: BookCardError());
              },
            ),
          ],
        ),
      ),
    );
  }
}
