import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/repositories/book_repository.dart';
import 'package:the_arabic_guide_app/repositories/notification_repository.dart';
import 'package:the_arabic_guide_app/repositories/profile__repository.dart';
import 'package:the_arabic_guide_app/repositories/quiz_repository.dart';
import 'package:the_arabic_guide_app/repositories/vocabulary_local_repository.dart';
import 'package:the_arabic_guide_app/repositories/vocabulary_local_repository.dart';
import '../data/vocabulary_data_source.dart';
import '../repositories/vocabulary_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register DataSource
  getIt.registerLazySingleton<VocabularyDataSource>(
      () => VocabularyDataSource());

  // Register VocabularyLocalRepository for Hive data
  getIt.registerLazySingleton<VocabularyLocalRepository>(
      () => VocabularyLocalRepository());

  // Register VocabularyRepository with both DataSource and LocalRepository dependencies
  getIt.registerLazySingleton<VocabularyRepository>(() => VocabularyRepository(
      getIt<VocabularyDataSource>(), getIt<VocabularyLocalRepository>()));

  // Register VocabularyRepository with both DataSource and LocalRepository dependencies
  getIt.registerLazySingleton(
      () => QuizRepository(getIt<VocabularyLocalRepository>()));

  // Register BookRepository
  getIt.registerLazySingleton<BookRepository>(() => BookRepository());

  // Register ProfileRepository
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());

  // Register NotificationRepository
  getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository());
}
