import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

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

  bool isInActorsList(Actor actor) {// Movie
    return watchListMovies.any((m) => m.id == actor.id);
  }

  void addToActorsList(Actor actor) {// Movie
    if (watchListMovies.any((m) => m.id == actor.id)) {
      watchListMovies.remove(actor);
      Get.snackbar('Success', 'removed from actors list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2));
    } else {
      watchListMovies.add(actor);
      Get.snackbar('Success', 'added to actors list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2));
    }
  }
}
