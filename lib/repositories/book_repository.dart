import '../models/book.dart';

class BookRepository {
  Future<List<Book>> fetchBooks() async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    // Sample book data
    return [
      Book(imageUrl: 'assets/images/book1.png', title: 'Book 1'),
      Book(imageUrl: 'assets/images/book2.png', title: 'Book 2'),
      Book(imageUrl: 'assets/images/book3.png', title: 'Book 3'),
      Book(imageUrl: 'assets/images/book4.png', title: 'Book 4'),
    ];
  }
}
