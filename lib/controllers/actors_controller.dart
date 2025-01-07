import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs; // Indica si los datos están siendo cargados
  var mainTopRatedActors = <Actor>[].obs; // Lista de actores más valorados
  var watchListActors = <Actor>[].obs; // Lista de actores guardados en la lista de seguimiento

  @override
  void onInit() async {// Se ejecuta al iniciar el controlador, se obtienen los actores más valorados    
    isLoading.value = true;
    mainTopRatedActors.value = (await ApiService.getTopRatedActors())!; // Obtiene los actores más valorados
    isLoading.value = false;
    super.onInit();
  }
  
  bool isInActorsList(Actor actor) {// Verifica si un actor ya está en la lista de actores de seguimiento
    return watchListActors.any((m) => m.id == actor.id); // Compara los IDs de los actores
  }

  void addToActorsList(Actor actor) {// Agrega o elimina un actor de la lista de seguimiento    
    if (watchListActors.any((m) => m.id == actor.id)) {// Si el actor ya está en la lista, lo elimina
      watchListActors.remove(actor);
      Get.snackbar('Success', 'removed from actors list', // Muestra un mensaje de éxito
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 1));
    } else {// Si el actor no está en la lista, lo agrega      
      watchListActors.add(actor);
      Get.snackbar('Success', 'added to actors list', // Muestra un mensaje de éxito
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 1));
    }
  }
}
