import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/infos.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34.0), // Padding para el contenido
            child: Column(
              children: [
                // Header (Cabecera)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacio entre elementos
                  crossAxisAlignment: CrossAxisAlignment.center, // Alineación de los elementos
                  children: [
                    IconButton(
                      tooltip: 'Back to home', // Texto de ayuda cuando se pasa el ratón
                      onPressed: () =>
                          Get.find<BottomNavigatorController>().setIndex(0), // Volver al índice 0 (pantalla principal)
                      icon: const Icon(
                        Icons.arrow_back_ios, // Ícono de flecha hacia atrás
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Actors list', // Título de la pantalla
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 33,
                      height: 33,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // Lista de actores
                if (Get.find<ActorsController>().watchListActors.isNotEmpty)
                  Column(
                    children: Get.find<ActorsController>()
                        .watchListActors
                        .map(
                          (actor) => Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Get.to(DetailsScreen(actor: actor)), // Redirigir a la pantalla de detalles del actor
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Imagen del actor
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16), // Esquinas redondeadas para la imagen
                                        child: Image.network(
                                          Api.imageBaseUrl + actor.profilePath, // URL de la imagen del actor
                                          height: 180,
                                          width: 120,
                                          fit: BoxFit.cover, // Ajustar la imagen al contenedor
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                            Icons.broken_image, // Ícono si la imagen no se carga
                                            size: 180,
                                          ),
                                          loadingBuilder: (_, __, ___) {
                                            // Si la imagen se está cargando
                                            if (___ == null) return __; // Imagen cargada
                                            return const FadeShimmer(
                                              width: 120,
                                              height: 180,
                                              highlightColor: Color(0xff22272f),
                                              baseColor: Color(0xff20252d),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Información del actor
                                      Expanded(
                                        child: Infos(actor: actor), // Mostrar detalles del actor
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                // Si la lista está vacía
                if (Get.find<ActorsController>().watchListActors.isEmpty)
                  const Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        'No actors in your watch list', // Mensaje cuando no hay actores en la lista
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
