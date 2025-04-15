import 'package:bookly/features/home/presentation/views/book_details_view.dart';
import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:bookly/features/search/presentation/views/search_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/views/splash_view.dart';

class AppRouter{
  static const kSplash='/';
  static const kHomeView='/homeView';
  static const kBookDetailsView='/kBookDetailsView';
  static const kSearchView='/kSearchView';
  static final router = GoRouter(

    routes: [
      GoRoute(
        path: kSplash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path:kBookDetailsView,
        builder: (context, state) => BookDetailsView(),
      ),
      GoRoute(
        path:kSearchView,
        builder: (context, state) => SearchView(),
      ),
    ],
  );
}