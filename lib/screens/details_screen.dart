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
    required this.actor,
  });
  final Actor actor; // Movie
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
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip(
                      message: 'Save this actor to your watch list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<ActorsController>().addToActorsList(actor);
                        
                        },
                        icon: Obx(
                          () =>
                              Get.find<ActorsController>().isInActorsList(actor)
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 33,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
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
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: SizedBox.expand(  // Esto hará que la imagen ocupe todo el ancho disponible
                          child: FittedBox(
                            fit: BoxFit.cover,  // Asegura que la imagen cubra el área sin distorsionar
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                              loadingBuilder: (_, __, ___) {
                                // ignore: no_wildcard_variable_uses
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
                                  Icons.broken_image,
                                  size: 250,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),                    
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // La imagen se ha cargado completamente
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
                              Icons.error,
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
                        child: Text(
                          actor.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ),
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
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              actor.popularity == 0.0// aqui
                                ? 'No data aviable'
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
                      width: constraints.maxWidth * 0.9, // Ajustar el ancho según el tamaño de la ventana
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/calender.svg'),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: FutureBuilder<DescActor?>(
                                  future: ApiService.getDetailyActor(actor.id.toString()),
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
                                          : 'No birthday available',
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
                              Icon(Icons.home, color: Colors.white, size: 17),
                              const SizedBox(width: 5),
                              FutureBuilder<DescActor?>(
                                future: ApiService.getDetailyActor(actor.id.toString()),
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
                                        : 'No place of birth available',
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
                            Tab(text: 'About Actors'),
                            Tab(text: 'Movies'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<DescActor?>(
                              future: ApiService.getDetailyActor(actor.id.toString()),
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
                                        : 'No biography aviable',
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
                          Container(),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
