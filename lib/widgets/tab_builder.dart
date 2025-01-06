import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen.dart';

class TabBuilder extends StatelessWidget {
  const TabBuilder({
    required this.future,
    super.key,
  });
  final Future<List<Actor>?> future;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      child: FutureBuilder<List<Actor>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              // Activar el scroll:
              physics: const ScrollPhysics(), // Esto permite el desplazamiento
              shrinkWrap: false, // Permitir que el GridView use el espacio disponible
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas
                crossAxisSpacing: 15.0, // Espaciado entre columnas
                mainAxisSpacing: 15.0, // Espaciado entre filas
                childAspectRatio: 0.6, // Relación entre ancho y alto
              ),
              itemCount: snapshot.data!.length, // Cambié a usar toda la lista
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(DetailsScreen(actor: snapshot.data![index]));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].profilePath}',
                    height: 300,
                    width: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 180,
                    ),
                    loadingBuilder: (_, __, ___) {
                      // ignore: no_wildcard_variable_uses
                      if (___ == null) return __;
                      return const FadeShimmer(
                        width: 180,
                        height: 250,
                        highlightColor: Color.fromARGB(255, 238, 0, 0),
                        baseColor: Color(0xff20252d),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
