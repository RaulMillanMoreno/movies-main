import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/descactor.dart';
import 'package:movies/api/api_service.dart';

class Infos extends StatelessWidget {
  const Infos({super.key, required this.movie});
  final Actor movie; // Cambia a Movie si es necesario

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Mantén la altura fija si es esencial
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // TÍTULO DEL ACTOR/PELÍCULA
          Flexible(
            child: Text(
              movie.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis, // Limita el título a una línea
              maxLines: 1, // Máximo 1 línea
            ),
          ),
          // DETALLES (POPULARIDAD, GÉNERO, ETC.)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popularidad
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/Star.svg',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      movie.popularity == 0.0
                          ? 'N/A'
                          : movie.popularity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFFFF8700),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Categoría o Género (Utils)
              Row(
                children: [
                  Icon(Icons.home,
                    color: Colors.white,
                    size: 17),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      child: FutureBuilder<DescActor?>(
                        future: ApiService.getDetailyActor(movie.id.toString()),
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
                            // Mostrar la biografía
                            return Text(
                              snapshot.data?.place_of_birth != null && snapshot.data?.place_of_birth != ""
                                ? snapshot.data!.place_of_birth.toString()
                                : 'No place of birth aviable',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No place of birth aviable (ERROR)',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Género
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/calender.svg',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      child: FutureBuilder<DescActor?>(
                        future: ApiService.getDetailyActor(movie.id.toString()),
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
                            // Mostrar la biografía
                            return Text(
                              snapshot.data?.birthday != null && snapshot.data?.birthday != ""
                                ? snapshot.data!.birthday.toString()
                                : 'No birthday aviable',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No birthday aviable (ERROR)',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
