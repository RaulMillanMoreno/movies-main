import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/descactor.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.actor, // Se recibe el actor a mostrar
  });
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home', // Acción para volver atrás
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios, // Icono de flecha hacia atrás
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail', // Título de la pantalla
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip(
                      message: 'Save this actor to your watch list', // Tooltip para añadir actor
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<ActorsController>().addToActorsList(actor); // Añadir actor a la lista
                        },
                        icon: Obx(
                          () =>
                            Get.find<ActorsController>().isInActorsList(actor)
                              ? const Icon(
                                  Icons.bookmark, // Icono de marcador si está en la lista
                                  color: Colors.white,
                                  size: 33,
                                )
                              : const Icon(
                                  Icons.bookmark_outline, // Icono de marcador vacío
                                  color: Colors.white,
                                  size: 33,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16), // Esquinas redondeadas
                          bottomRight: Radius.circular(16),
                        ),
                        child: SizedBox.expand( // Expande el área de la imagen
                          child: FittedBox(
                            fit: BoxFit.cover, // Cubre todo el espacio sin distorsionar la imagen
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${actor.profilePath}', // URL de la imagen del actor
                              loadingBuilder: (_, __, ___) {
                                // Si la imagen está cargando
                                if (___ == null) return __; 
                                return FadeShimmer(
                                  width: Get.width,
                                  height: 250,
                                  highlightColor: const Color(0xff22272f),
                                  baseColor: const Color(0xff20252d),
                                );
                              },
                              errorBuilder: (_, __, ___) => const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image, // Icono si la imagen no se carga
                                  size: 250,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Imagen pequeña del actor
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${actor.profilePath}', // Imagen del actor
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover, // Asegura que la imagen se ajuste correctamente
                            loadingBuilder: (_, child, loadingProgress) {
                              // Si está cargando la imagen
                              if (loadingProgress == null) {
                                return child; // Imagen cargada
                              } else {
                                return const FadeShimmer(
                                  width: 110,
                                  height: 140,
                                  highlightColor: Color(0xff22272f),
                                  baseColor: Color(0xff20252d),
                                ); // Imagen aún cargando
                              }
                            },
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person_off, // Icono de error en caso de fallo en la carga
                              size: 120,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Container(// container con fondo blanco
                          color: Colors.white,
                          child: Text(
                            actor.name, // Nombre del actor
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        )                        
                      ),
                    ),
                    // Información sobre la popularidad
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'), // Icono de estrella
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              actor.popularity == 0.0
                                ? 'No data available' // Si no hay datos de popularidad
                                : actor.popularity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth * 0.9, // Ajustar el ancho
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/calender.svg'), // Icono de calendario
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: FutureBuilder<DescActor?>( // Obtener detalles del actor
                                  future: ApiService.getDetailActor(actor.id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          'Error: ${snapshot.error}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      );
                                    } else if (snapshot.hasData && snapshot.data != null) {
                                      return Text(
                                        snapshot.data?.birthday != null && snapshot.data?.birthday != "" 
                                          ? snapshot.data!.birthday.toString()
                                          : 'No birthday available', // Muestra el cumpleaños si está disponible
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          'No birthday available (ERROR)',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Text('|'),
                          Row(
                            children: [
                              Icon(Icons.home, color: Colors.white, size: 17), // Icono de lugar de nacimiento
                              const SizedBox(width: 5),
                              FutureBuilder<DescActor?>( // Obtener el lugar de nacimiento
                                future: ApiService.getDetailActor(actor.id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else if (snapshot.hasData && snapshot.data != null) {
                                    return Text(
                                      snapshot.data?.place_of_birth != null && snapshot.data?.place_of_birth != ""
                                        ? snapshot.data!.place_of_birth.toString()
                                        : 'No place of birth available', // Muestra el lugar de nacimiento si está disponible
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                        'No place of birth available (ERROR)',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'About Actors'), // Pestaña sobre el actor
                            Tab(text: 'Movies'), // Pestaña de películas
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<DescActor?>( // Obtener biografía del actor
                              future: ApiService.getDetailActor(actor.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  );
                                } else if (snapshot.hasData && snapshot.data != null) {
                                  return SingleChildScrollView(
                                    child: Text(
                                    snapshot.data?.biography != null && snapshot.data?.biography != ""
                                        ? snapshot.data!.biography
                                        : 'No biography available', // Muestra la biografía si está disponible
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      'No biography available (ERROR)',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(), // Espacio para la segunda pestaña (películas)
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
