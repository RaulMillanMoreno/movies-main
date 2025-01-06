import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/widgets/tab_builder.dart';
import 'package:movies/widgets/top_rated_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ActorsController controller = Get.put(ActorsController());
  final SearchController1 searchController = Get.put(SearchController1());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Who do you want to see?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController1>().searchController.text;
                Get.find<SearchController1>().searchController.text = '';
                Get.find<SearchController1>().search(search);
                Get.find<BottomNavigatorController>().setIndex(1);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            Obx(
              (() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        itemCount: controller.mainTopRatedActors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => TopRatedItem(
                            actor: controller.mainTopRatedActors[index],// es donde se daba el error para los actores.
                            index: index + 1),
                      ),
                    )),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                      indicatorWeight: 3,
                      indicatorColor: Color(
                        0xFF3A3F47,
                      ),
                      labelStyle: TextStyle(fontSize: 11.0), 
                      tabs: [
                        Tab(text: 'first podium'),
                        Tab(text: 'second podium'),
                        Tab(text: 'third podium'),
                      ]),
                  SizedBox(
                    height: 400,
                    child: TabBarView(children: [
                      TabBuilder(
                        future: ApiService.getCustomActors(//eran el de pelis
                            '&page=1'),
                      ),
                      TabBuilder(
                        future: ApiService.getCustomActors(//eran el de pelis
                            '&page=2'),
                      ),
                      TabBuilder(
                        future: ApiService.getCustomActors(//eran el de pelis
                            '&page=3'),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
