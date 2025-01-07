import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';

class Main extends StatelessWidget {
  Main({super.key});
  // Instancia del controlador de la barra de navegación
  final BottomNavigatorController controller = Get.put(BottomNavigatorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          // Desenfocar el foco cuando se toca fuera de los campos de texto
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            // Muestra la pantalla actual según el índice
            child: IndexedStack(
              index: controller.index.value,
              children: Get.find<BottomNavigatorController>().screens,
            ),
          ),
          bottomNavigationBar: Container(
            height: 78,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.index.value, // Ítem seleccionado actualmente
              onTap: (index) =>
                  // Cambia el índice del controlador para navegar entre pantallas
                  Get.find<BottomNavigatorController>().setIndex(index),
              backgroundColor: const Color(0xFF242A32), 
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D), 
              selectedFontSize: 12, 
              unselectedFontSize: 12, 
              items: [
                // Primer ítem (Home)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Home.svg',
                      height: 21,
                      width: 21,
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5) 
                          : const Color(0xFF67686D), 
                    ),
                  ),
                  label: 'Home',
                ),
                // Segundo ítem (Search)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Search.svg',
                      height: 21,
                      width: 21,
                      color: controller.index.value == 1
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Search',
                  tooltip: 'Search Actors', // Tooltip que aparece al pasar el cursor
                ),
                // Tercer ítem (Save/Actors list)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Save.svg',
                      height: 21,
                      width: 21,
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Actors list',
                  tooltip: 'Your ActorsList', // Tooltip para este ítem
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
