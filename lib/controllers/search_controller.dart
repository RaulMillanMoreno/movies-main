import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class SearchController1 extends GetxController {
  // Controlador de texto para el campo de búsqueda
  TextEditingController searchController = TextEditingController();  
  var searchText = ''.obs; // Texto de búsqueda
  var foundedActors = <Actor>[].obs; // Lista de actores encontrados
  var isLoading = false.obs; // Indica si los datos están siendo cargados
  // Método para actualizar el texto de búsqueda
  void setSearchText(text) => searchText.value = text;  
  void search(String query) async {// Método para realizar la búsqueda de actores
    isLoading.value = true;
    foundedActors.value = (await ApiService.getSearchedActors(query)) ?? []; // Realiza la búsqueda y obtiene los actores
    isLoading.value = false;
  }
}
