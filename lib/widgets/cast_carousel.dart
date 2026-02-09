import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/models/movie_credits_response.dart';
import 'package:flutter_tmdb/widgets/actor_card.dart';

class CastCarousel extends StatelessWidget {
  final List<Cast> castList;

  const CastCarousel({
    super.key,
    required this.castList,
  });

  @override
  Widget build(BuildContext context) {
    if (castList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('No hay datos de actores disponibles'),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          return ActorCard(actor: castList[index]);
        },
      ),
    );
  }
}
