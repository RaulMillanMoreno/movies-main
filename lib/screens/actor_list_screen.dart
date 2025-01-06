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
            padding: const EdgeInsets.all(34.0),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () =>
                          Get.find<BottomNavigatorController>().setIndex(0),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Actors list',
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
                // Lista de películas
                if (Get.find<ActorsController>().watchListActors.isNotEmpty)
                  Column(
                    children: Get.find<ActorsController>()
                        .watchListActors
                        .map(
                          (actor) => Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Get.to(DetailsScreen(actor: actor)),
                                child: 
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Imagen de la película
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          Api.imageBaseUrl + actor.profilePath,
                                          height: 180,
                                          width: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                            Icons.broken_image,
                                            size: 180,
                                          ),
                                          loadingBuilder: (_, __, ___) {
                                            // ignore: no_wildcard_variable_uses
                                            if (___ == null) return __;
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
                                      // Información de la película
                                      Expanded(
                                        child: Infos(actor: actor),
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
                        'No actors in your watch list',
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
