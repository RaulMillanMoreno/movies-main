import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';

class MoviesController extends GetxController {
  var isLoading = false.obs;
  var mainTopRatedMovies = <Actor>[].obs; // Movie
  var watchListMovies = <Actor>[].obs; // Movie
  @override
  void onInit() async {
    isLoading.value = true;
    mainTopRatedMovies.value = (await ApiService.getTopRatedActors())!;
    isLoading.value = false;
    super.onInit();
  }

  bool isInActorsList(Actor movie) {// Movie
    return watchListMovies.any((m) => m.id == movie.id);
  }

  void addToActorsList(Actor movie) {// Movie
    if (watchListMovies.any((m) => m.id == movie.id)) {
      watchListMovies.remove(movie);
      Get.snackbar('Success', 'removed from actors list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2));
    } else {
      watchListMovies.add(movie);
      Get.snackbar('Success', 'added to actors list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2));
    }
  }
}
