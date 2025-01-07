import 'package:get/get.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/actor_list_screen.dart';

class BottomNavigatorController extends GetxController {
  // Lista de pantallas disponibles en el navegador inferior
  var screens = [
    HomeScreen(), // Pantalla principal de inicio
    const SearchScreen(), // Pantalla de búsqueda
    const WatchList(), // Pantalla de lista de seguimiento
  ];  
  var index = 0.obs;// Índice actual de la pantalla seleccionada  
  void setIndex(indx) => index.value = indx;// Método para actualizar el índice de la pantalla seleccionada
}
