class FavoriteBook {
  final String id;
  final String? image;
  final String? title;
  final String? subTitle;
  final String? authors;
  final String? publisher;
  final int? pageCount;
  final String? publishedDate;

  FavoriteBook(
      {required this.id,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.authors,
      required this.publisher,
      required this.pageCount,
      required this.publishedDate});

  factory FavoriteBook.fromJson(Map<String, dynamic> data) => FavoriteBook(
        id: data['id'],
        image: data['image'],
        title: data['title'],
        subTitle: data['subTitle'],
        authors: data['authors'],
        publisher: data['publisher'],
        pageCount: data['pageCount'],
        publishedDate: data['publishedDate'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'title': title,
        'subTitle': subTitle,
        'authors': authors,
        'publisher': publisher,
        'pageCount': pageCount,
        'publishedDate': publishedDate
      };
}
