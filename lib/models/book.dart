class Book {
  String title;
  String authors;
  String pages;
  String year;
  String publisher;
  String language;
  String subtitle;
  String isbn13;
  String price;
  String image;
  String url;
  String rating;
  String desc;

  Book({
    this.title = "Title",
    this.subtitle = "Subtitle",
    this.isbn13 = "ISBN13",
    this.price = "Price",
    this.image = "Image",
    this.url = "URL",
    this.authors = "Authors",
    this.year = "Year",
    this.language = "Language",
    this.publisher = "Publisher",
    this.pages = "num. pages",
    this.rating = "0",
    this.desc = "Description",
  });

  factory Book.bookListFromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Title not available!',
      subtitle: json['subtitle'] ?? 'Subtitle not available!',
      isbn13: json['isbn13'] ?? 'Isbn not available!',
      price: json['price'] ?? 'Price not available!',
      image: json['image'] ?? 'Image not available!',
      url: json['url'] ?? 'Url not available!',
    );
  }

  factory Book.bookDetailsFromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Title not available!',
      subtitle: json['subtitle'] ?? 'Subtitle not available!',
      authors: json['authors'] ?? 'Authors not available!',
      year: json['year'] ?? 'Year not available!',
      language: json['language'] ?? 'Language not available!',
      publisher: json['publisher'] ?? 'Publisher not available!',
      pages: json['pages'] ?? 'Pages not available!',
      isbn13: json['isbn13'] ?? 'Isbn not available!',
      price: json['price'] ?? 'Price not available!',
      image: json['image'] ?? 'Image not available!',
      url: json['url'] ?? 'Url not available!',
      rating: json['rating'] ?? 'Rating not available!',
      desc: json['desc'] ?? 'Description not available!',
    );
  }
}
