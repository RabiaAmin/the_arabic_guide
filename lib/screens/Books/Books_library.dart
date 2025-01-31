import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/models/book.dart';
import 'package:the_arabic_guide_app/repositories/book_repository.dart';
import 'package:the_arabic_guide_app/screens/Books/widgets/Book_Item.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';

class BooksLibrary extends StatefulWidget {
  const BooksLibrary({super.key});

  @override
  State<BooksLibrary> createState() => _BooksLibraryState();
}

class _BooksLibraryState extends State<BooksLibrary> {
  final BookRepository bookRepository = GetIt.I<BookRepository>();
  late Future<List<Book>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = bookRepository.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: kAccentColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockH! * 5,
            color: const Color.fromARGB(88, 0, 150, 135),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "You can also buy these books from our website",
                style: TextStyle(color: Colors.teal),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: SizeConfig.blockH! * 5,
            color: const Color.fromARGB(88, 0, 150, 135),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "TheArabicGuide.com",
                style: TextStyle(color: Colors.teal),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: booksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No books available"));
                } else {
                  final books = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookItem(
                        imageUrl: book.imageUrl,
                        title: book.title,
                        onViewPressed: () {
                          // Handle view action
                        },
                        onDownloadPressed: () {
                          // Handle download action
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
